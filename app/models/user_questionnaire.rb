class UserQuestionnaire < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user, touch: true
  belongs_to :questionnaire
  belongs_to :resource, polymorphic: true, optional: true, touch: true
  belongs_to :origination_section, ->{joins(:user_questionnaire).where(user_questionnaires: {resource_type: 'OriginationSection'})}, class_name: 'OriginationSection', foreign_key: 'resource_id', optional: true
  belongs_to :application,touch: true, optional: true
  has_many :user_questionnaire_answer, -> { joins(answer: :question).where('questions.discarded_at IS NULL')}, dependent: :destroy
  has_many :user_questionnaire_score, dependent: :destroy
  has_one :questionnaire_exception, dependent: :destroy
  has_many :user_questionnaire_follow_up, dependent: :destroy

  validate :uniq_questionnaire_by_application, on: :create


  after_commit :score_test
  after_commit :flush_ongoing_questionnaire


  def answered? answer
    self.user_questionnaire_answer.select{|a| a.answer_id == answer.id}.any?
  end

  def selected_answer question
    self.user_questionnaire_answer.select{|a| a.answer.question_id == question.id}.first
  end

  def main_score
    score = self.user_questionnaire_score.find_by(questionnaire_id: self.questionnaire_id)
    if score.nil?
      result = 0
    else
      result = score.score
    end
    return result
  end


  def flush_ongoing_questionnaire
    Rails.cache.delete(['cached_ongoing_questionnaire',self.user_id])
    Rails.cache.delete(['cached_questionnaire_mode',self.user_id])
    begin
      if !self.application_id.nil?
        application = self.application
        Rails.cache.delete(['applicationcached_done?',application.current_section_id,'-',application.id])
      end  
    rescue Exception => e
      nil      
    end
  end

  def completion_percentage
    (self.total_answers.to_f/self.total_questions.to_f*100).round(1)
  end

  def total_questions
    self.questionnaire.total_questions
  end

  def total_answers
    self.user_questionnaire_answer.count
  end

  def final_result
    result = nil
    if !self.questionnaire_exception.nil?
      result = I18n.t('list.special_approve')
    elsif self.approved?
      result = I18n.t('list.approved')
    elsif self.status == 'finished' && !self.approved?
      result = I18n.t('list.failed')
    end
    return result
  end

  def scored?
    self.user_questionnaire_score.any? || self.questionnaire_exception.present?
  end



  def approved?
    if self.status == 'finished'
      result = self.scored? && (self.user_questionnaire_score.includes(:questionnaire).map{|score| score.approved?}.index(false).nil? || !self.questionnaire_exception.nil?)
    else
        self.questionnaire_exception.present? ? result = true : result = false
    end
    return result
  end

  def score_test
    if self.status == 'finished'
      questionnaire = Questionnaire.cached_find(self.questionnaire_id)
      target_questionnaire_ids = questionnaire.supervising.where(subordinate_type: 'Questionnaire').map{|q| q.subordinate_id}
      questionnaires = Questionnaire.where(id: target_questionnaire_ids).kept

      questionnaires.each do |section|
        if self.user_questionnaire_score.find_by_questionnaire_id(section.id).nil?
          UserQuestionnaireScore.create({user_questionnaire_id: self.id, questionnaire_id: section.id})
        end
      end

      answers = Answer.where(id: self.user_questionnaire_answer.map{|a| a.answer_id}).kept
      questions = Question.where(id: answers.map{|a| a.question_id}).kept
      base_questionnaire = Questionnaire.where(id: questions.map{|q| q.questionnaire_id}).kept



      base_questionnaire.each do |section|
        max_score = section.question.sum(:max_score)
        answer_score = answers.where(question_id: section.question.ids).sum(:score)
        final_score = answer_score/max_score*section.max_score
        self.user_questionnaire_score.find_by_questionnaire_id(section.id).update(score: final_score)
      end

      temp_parents = base_questionnaire.map{|q| q.parent_id}.uniq.compact
      temp_gran_parents = Questionnaire.where(id: temp_parents).map{|q| q.parent_id}.uniq.compact
      parents = temp_parents - temp_gran_parents

      while parents.length > 0
        parents.each do |section_id|
          section = Questionnaire.cached_find(section_id)
          scores_array = section.childs.map{|s| s.weight/100 * s.user_questionnaire_score.find_by_user_questionnaire_id(self.id).score.to_f}
          score = scores_array.inject(0){|sum,x| sum + x }
          self.user_questionnaire_score.find_by_questionnaire_id(section_id).update(score: score)
        end

        temp_parents = Questionnaire.where(id: parents).map{|q| q.parent_id}.uniq.compact
        temp_gran_parents = Questionnaire.where(id: temp_parents).map{|q| q.parent_id}.uniq.compact
        parents = temp_parents - temp_gran_parents

      end
    end
  end


  def actions_after_score

      # After Score Actions

      case self.application.resource_type
      when 'FundingOpportunity'
        if self.approved?
          # The application is not approved because the process does not finish until the contract is activated
          #self.application.update(show_financial_proposals: true)
        else
          application = self.application
          application.result = 'fail'
          application.decision = 'rejected'
          application.save
        end
      when 'Disbursement'
        if self.approved?
          application = self.application
          application.result = 'approved'
          # It's pending to trigger the disbursement_matches creation
          application.status = 'pending'
          application.decision = 'approved'
          application.save
          # update disbursements
          application.resource.update(status: 'approved')
        else
          application = self.application
          application.result = 'fail'
          application.status = 'inactive'
          application.decision = 'rejected'
          application.save

          # update disbursements
          application.resource.update(status: 'generated')
        end
      else
        if self.approved?
          application = self.application
          application.result = 'approved'
          application.status = 'approved'
          application.decision = 'approved'
          application.save
        else
          application = self.application
          application.result = 'fail'
          application.status = 'inactive'
          application.decision = 'rejected'
          application.save
        end
      end

  end

  def remaining_questions
  	questionnaire = Questionnaire.cached_find(self.questionnaire_id)
  	questions = questionnaire.remaining_questions(self.questions_anwered)
  	return questions
  end

  def ordering_questions target_ids
    target_Questions = ObjectOrder.where(subordinate_id: target_ids, subordinate_type: 'Question').order(:subordinate_id,:level,:position).to_a
    target_hash = {}
    target_Questions.group_by{|question| question.subordinate_id}.values.each do |questions|
      target_hash[questions.first.subordinate_id] = questions.map{|q| q.position}
    end
    target_hash.keys.sort_by {|q| target_hash[q].map(&:to_i) }
  end

  def ordered_remaining_questions
    self.ordering_questions(self.remaining_questions.ids)
  end

  def ordered_all_questions(questionnaire)
    self.ordering_questions(questionnaire.all_questions)
  end


  def current_step
  	current_answers = self.user_questionnaire_answer
  end

  def number_answers
  	self.user_questionnaire_answer.count
  end

  def questions_anwered
  	temp_answers = self.user_questionnaire_answer.map{|a| a.answer_id}.uniq
  	Answer.where(id: temp_answers).map{|a| a.question_id}
  end

  def all_questions
  	self.questionnaire.all_questions
  end

  def pending_questions
  	self.all_questions - self.questions_anwered
  end

  def percentage_progress
  	(self.questions_anwered.count.to_f/self.total_questions * 100).round(1)
  end

  def time
    unless self.end_time.nil?
      time_difference = self.end_time - self.start_time
      total_minutes = (time_difference/1.minute).round
      return "#{total_minutes.to_s} Mins."
    end
  end

  def user_questionnaire_name
    self.questionnaire.name
  end


  private

  def uniq_questionnaire_by_application
    errors.add(:id, "There is another user questionneire with matching information") unless duplicated_user_questionnaire
  end

  def duplicated_user_questionnaire
    UserQuestionnaire.find_by({user_id: self.user_id, 
                              questionnaire_id: self.questionnaire_id,
                              resource_type: self.resource_type, 
                              resource_id: self.resource_id, 
                              application_id: self.application_id}).nil?
  end

end
