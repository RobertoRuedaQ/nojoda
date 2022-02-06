class Sociodemographic < ApplicationRecord
      
      resourcify
      audited
  belongs_to :city, class_name: 'Geography', foreign_key: 'city_id', optional: true
  belongs_to :state, class_name: 'Geography', foreign_key: 'state_id', optional: true
  belongs_to :country, class_name: 'Geography', foreign_key: 'country_id', optional: true
  belongs_to :user,touch: true

    has_one_attached :social_service_certificate
    has_one_attached :indigenous_community_certificate
    has_one_attached :residence_certificate
    has_one_attached :utility_bill
    has_one_attached :extra_file


  def country_name
    if !self.country.nil?
      @response = self.country.label
    end
    return @response
  end

  def state_name
    if !self.state.nil?
      @response = self.state.label
    end
    return @response
  end

  def city_name
    if !self.city.nil?
      @response = self.city.label
    end
    return @response
  end

    
end
