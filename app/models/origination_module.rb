class OriginationModule < ApplicationRecord
      
  resourcify
  audited
  belongs_to :origination,touch: true
  has_many :origination_section, -> { order(:order).kept }, dependent: :destroy
  has_many :application_module_track


  def done? application
    return true unless module_pending_for_trakking?(application)
    done = self.cached_origination_section.map{|section| section.done?(application, section)}.all?
    if done == true
      CreateRecordAsync.perform_async('application_module_track', {origination_module_id: self.id, application_id: application.id})
    end
    return done
  end

  def module_pending_for_trakking?(application)
    self.application_module_track.select{|a| a.application_id == application.id}.empty?
  end

  
  def cached_origination_section
  	Rails.cache.fetch(['cached_origination_section_from_module',self.id],exprires_in: 1.day){origination_section.kept.to_a}
  end
end
