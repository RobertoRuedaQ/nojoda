class Answer < ApplicationRecord
    resourcify
  audited except: :position
  belongs_to :question, touch: true
  has_many :supervising, as: :superior ,class_name: 'ObjectOrder', dependent: :destroy
  has_many :subordinated, as: :subordinate ,class_name: 'ObjectOrder', dependent: :destroy
  has_many :user_questionnaire_answer, dependent: :destroy

  after_create :set_lumni_order
  after_commit :adjust_order, on: [:create, :update]

  def adjust_order
    self.supervising.cached_update_all({position: self.position})
  end
  

  def set_lumni_order
    parentRecords = self.question.subordinated
    parentRecords.each do |sub|
      sub.subordinate_id = self.id
      sub.subordinate_type = self.class.name
    end
    self.subordinated << parentRecords.map{|s| s.dup}
    self.subordinated << ObjectOrder.new(level: parentRecords.maximum(:level) + 1, superior_id: self.id,superior_type: self.class.name,position: self.position)
    self.save
  end

  def answered? target_user_questionnaire
    !UserQuestionnaireAnswer.find_by(answer_id: self.id,user_questionnaire_id: target_user_questionnaire.id).nil?
  end

end
