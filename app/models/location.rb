class Location < ApplicationRecord
  resourcify
  audited

	belongs_to :resource, polymorphic: true,touch: true
  belongs_to :city, class_name: 'Geography', foreign_key: 'city_id', optional: true
  belongs_to :state, class_name: 'Geography', foreign_key: 'state_id', optional: true
  belongs_to :country, class_name: 'Geography', foreign_key: 'country_id', optional: true

  belongs_to :institution,->{joins(:location).where(locations:{resource_type: 'Institution'})},class_name: 'Institution', foreign_key: 'resource_id', optional: true

  has_one_attached :residence_certificate

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

  def origination
		self.resource.funds.first.student_location_origination
	end

end
