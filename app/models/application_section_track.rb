class ApplicationSectionTrack < ApplicationRecord
      
      resourcify
      audited
  belongs_to :application
  belongs_to :origination_section

  after_commit :flush_origination_section

  
  def flush_origination_section
  	Rails.cache.delete(['applicationcached_done?',self.origination_section_id,'-',self.application_id])
  end

end
