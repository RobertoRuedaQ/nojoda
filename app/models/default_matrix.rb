class DefaultMatrix < ApplicationRecord
      
      resourcify
      audited
  belongs_to :country

  def country_name
  	country.name
  end
end
