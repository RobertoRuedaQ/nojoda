class Origination < ApplicationRecord
  resourcify
  audited
  has_many :origination_module, -> { order(:order).kept }, dependent: :destroy
  has_many :student_route, -> { order(:id) }, as: :resource , dependent: :destroy
  has_many :funding_opportunity


  after_create :create_student_routes
  after_commit :flush_origination

  def create_student_routes
  	target_actions = ['apply','contract_activation']
  	target_actions.each do |action|
  		target_profile = TeamProfile.find_by_action(action)
  		StudentRoute.create({resource_id: self.id, resource_type: 'Origination',scenario: action, team_profile_id: target_profile.id})
  	end
  end

  def current_step application
    step = self.origination_module.kept.map{|m| m.done?(application)}.index(false)
    if step.nil?
      step = self.origination_module.count
    end
    return step
  end

  def flush_origination
    Rails.cache.delete(['cached_origination_by_id_funding_opportunity',self.id])
    Rails.cache.fetch(['cached_sections_funding_opportunity',self.id])
    Rails.cache.delete(['cached_origination_by_id_disbursement',self.id])
    Rails.cache.fetch(['cached_sections_disbursement',self.id])
  end


end
