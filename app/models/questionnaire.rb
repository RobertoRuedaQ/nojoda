class Questionnaire < ApplicationRecord
  resourcify
  audited except: :position
  belongs_to :parent,:class_name => 'Questionnaire', foreign_key: 'parent_id', optional: true, touch: true
  belongs_to :company, optional: true
  has_many :childs, -> { kept.order(:position) },:class_name => 'Questionnaire', foreign_key: 'parent_id', dependent: :destroy
  has_many :question, -> { kept.order(:position) }, dependent: :destroy
  has_many :supervising, -> { order(:level) }, as: :superior ,class_name: 'ObjectOrder', dependent: :destroy
  has_many :subordinated, -> { order(:level) }, as: :subordinate ,class_name: 'ObjectOrder', dependent: :destroy
  has_many :all_questions, -> { where(discarded_at: nil) }, through: :supervising, source: :subordinate, source_type: 'Question'
  has_many :user_questionnaire, -> {kept}, dependent: :destroy
  has_many :user_questionnaire_score, -> {kept}, dependent: :destroy
  has_many :questionnaire_accumulation, -> {kept},dependent: :destroy
  has_many :origination_section, as: :resource

  scope :main, -> (){ where(parent: nil).kept }
  scope :kept_childs, -> { includes(:childs,{question: [:answer]}).where(childs_questionnaires: {discarded_at: nil},questions: {discarded_at: nil, answers: {discarded_at: nil}}) }

  after_commit :cached_flush_questionnaire
  after_create :set_lumni_order
  after_commit :adjust_order, on: [:create, :update]
  after_commit :discard_supervising_items



  def reasign_questionnaire_isa_application funding_opportunity_ids
    ## Use Example
    # questionnaire_ids = [149734,149740,149803]
    # Questionnaire.where(id: questionnaire_ids).map{|questionnaire| questionnaire.reasign_questionnaire_isa_application([228,225,227])}
    funding_opportunity_ids.each do |funding_opportunity_id|
      applications = Application.select(:id,:user_id).joins(:funding_opportunity_from_resource).where(resource_id: funding_opportunity_id)
      ok_application = applications.select(:id).joins(:user_questionnaire).where(user_questionnaires: {questionnaire_id: self.id}).distinct.ids
      review_application = applications.where.not(id: ok_application)
      section = self.origination_section.joins(origination_module: [origination: :funding_opportunity]).find_by('funding_opportunities.id = ?',funding_opportunity_id)
      if section.present?
        review_application.each do |application|
          UserQuestionnaire.create({user_id: application.user_id, questionnaire_id: self.id, status: "active", resource_type: "OriginationSection", resource_id: section.id, application_id: application.id})
        end
      end
    end
  end





  def discard_supervising_items
    if !self.discarded_at.nil?
      self.supervising.each do |s|
        s.subordinate.discard
      end
    end
  end

  def main_questionnaire
    self.subordinated.where(level: 1).first.superior
  end


  def completion_percentage user_questionnaire_id
    (self.total_answers(user_questionnaire_id).to_f/self.total_questions.to_f*100).round(1)
  end

  def total_questions
    self.all_questions.count
  end


  def total_answers user_questionnaire_id
    user_questionnaire = UserQuestionnaire.cached_find(user_questionnaire_id)
    target_answers_ids = self.supervising.where(subordinate_type: 'Answer').map{|a| a.subordinate_id}
    user_questionnaire.user_questionnaire_answer.where(answer_id: target_answers_ids).count
  end

  def total_score user_questionnaire_id
    self.user_questionnaire_score.where(user_questionnaire_id: user_questionnaire_id).first.score
  end



  def adjust_order
    self.supervising.cached_update_all({position: self.position})
  end

  def remaining_questions questions_answered
    Question.joins(:subordinated).kept.where(object_orders: {superior_id: self.id,superior_type: 'Questionnaire'}).where.not(id: questions_answered)
  end


  def self.cached_questionnaire targetId
  	Rails.cache.fetch(['cached_questionnaire',targetId]){kept_childs.find(targetId)}
  end

  def cached_question
  	Rails.cache.fetch(['cached_question',id]){question.kept.to_a}
  end

  def cached_question_count
  	Rails.cache.fetch(['cached_question_count',id]){question.kept.count}
  end

  def cached_childs
  	Rails.cache.fetch(['cached_childs',id]){childs.kept.to_a}
  end

  def cached_childs_count
  	Rails.cache.fetch(['cached_childs_count',id]){childs.kept.count}
  end


  def cached_flush_questionnaire
  	Rails.cache.delete(['cached_questionnaire',id])
  	Rails.cache.delete(['cached_question',id])
  	Rails.cache.delete(['cached_question_count',id])
  	Rails.cache.delete(['cached_childs',id])
  	Rails.cache.delete(['cached_childs_count',id])
  end

  def set_lumni_order
    if self.parent.nil?
      self.supervising << ObjectOrder.new(level: 1, subordinate_id: self.id,subordinate_type: self.class.name)
      self.save
    else
      parentRecords = self.parent.subordinated
      parentRecords.each do |sub|
        sub.subordinate_id = self.id
        sub.subordinate_type = self.class.name
      end
      self.subordinated << parentRecords.map{|s| s.dup}
      self.subordinated << ObjectOrder.new(level: parentRecords.maximum(:level) + 1, superior_id: self.id,superior_type: self.class.name,position: self.position)
      self.save
    end
  end





end
