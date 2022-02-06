class Ipc < ApplicationRecord
      
      resourcify
      audited
  belongs_to :country


  def self.factor base_date, country_id
  	begin
	  	self.ipc_past_year(Time.now.to_date,country_id) / self.ipc_past_year(base_date,country_id)
  	rescue Exception => e
  		1
  	end
  end

  def self.ipc_past_year base_date, country_id
  	Ipc.find_by(month: 12, year: (base_date.year - 1),country_id: country_id).value.to_f
  end

  def country_name
    self.country.name || ''
  end
end
