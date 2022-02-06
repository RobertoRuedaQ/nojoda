class Question < ApplicationRecord
  resourcify
  audited except: :position


  has_one_attached :illustration
  has_many :answer,->{order(:position).kept}, dependent: :destroy
  has_many :supervising, -> { order(:level) }, as: :superior ,class_name: 'ObjectOrder', dependent: :destroy
  has_many :subordinated, -> { order(:level) }, as: :subordinate ,class_name: 'ObjectOrder', dependent: :destroy
  belongs_to :questionnaire, touch: true

  after_commit :flush_cached_question
  after_create :set_lumni_order
  after_commit :adjust_order, on: [:create, :update]

  def answered? user_questionnaire
    self.selected_answer user_questionnaire.nil?
  end

  def selected_answer user_questionnaire
    UserQuestionnaireAnswer.find_by(answer_id: self.answer.ids,user_questionnaire_id: user_questionnaire.id)
  end

  def adjust_order
    self.supervising.cached_update_all({position: self.position})
  end

  def main_questionnaire
    self.subordinated.where(level: 1).first.superior
  end


  def enumerator
    self.subordinated.map{|q| q.superior.position}
  end

  def cached_answer
  	Rails.cache.fetch(['cached_answer',id]){answer.kept.to_a}
  end

  def flush_cached_question
  	Rails.cache.delete(['cached_answer',id])
  end

  def set_lumni_order
    parentRecords = self.questionnaire.subordinated
    parentRecords.each do |sub|
      sub.subordinate_id = self.id
      sub.subordinate_type = self.class.name
    end
    self.subordinated << parentRecords.map{|s| s.dup}
    self.subordinated << ObjectOrder.new(level: parentRecords.maximum(:level) + 1, superior_id: self.id,superior_type: self.class.name,position: self.position)
    self.save
  end

end
