class Geography < ApplicationRecord
      
      resourcify
      audited
  belongs_to :geography,optional: true
  has_many :sections, class_name: 'Geography',foreign_key: 'geography_id',dependent: :destroy
  has_many :location_country, class_name: 'Location',foreign_key: 'country_id'

  after_commit :flush_geography


  def self.all_countries
  	Geography.kept.where(type_of_geography: 'country')
  end
  def self.cached_all_countries
  	Rails.cache.fetch(['cached_all_countries_geography']){Geography.kept.where(type_of_geography: 'country').to_a}
  end

  def self.cached_subgroup  parent_id
    Rails.cache.fetch(['geography_cached_subgroup',parent_id]){Geography.where(geography_id: parent_id).to_a}
  end

  def flush_geography
  	if self.type_of_geography == 'country'
  		Rails.cache.delete(['cached_all_countries_geography'])
  	end
    Rails.cache.fetch(['geography_cached_subgroup',self.geography_id])
  end
end
