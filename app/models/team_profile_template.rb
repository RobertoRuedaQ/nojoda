class TeamProfileTemplate < ApplicationRecord
      
      resourcify
      audited
  belongs_to :form_template
  belongs_to :team_profile

  after_commit :flush_team_profile_template

  def object
  	self.form_template.object
  end

  def cached_object
  	Rails.cache.fetch([self.form_template_id,'cached_object']){object}
  end

  def flush_team_profile_template
  	Rails.cache.delete([self.form_template_id,'cached_object'])
    Rails.cache.fetch([team_profile_id,'cached_objects'])
  end

end
