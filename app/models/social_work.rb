class SocialWork < ApplicationRecord
      
      resourcify
      audited
  belongs_to :city, class_name: 'Geography', foreign_key: 'city_id', optional: true
  belongs_to :state, class_name: 'Geography', foreign_key: 'state_id', optional: true
  belongs_to :country, class_name: 'Geography', foreign_key: 'country_id', optional: true
  belongs_to :user

  has_one_attached :social_work_certificate

  def country_name
    self.country.label unless self.country.nil?
  end

  def state_name
    self.state.label unless self.country.nil?
  end

  def city_name
    self.city.label unless self.country.nil?
  end
end
