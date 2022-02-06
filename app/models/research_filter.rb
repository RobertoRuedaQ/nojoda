class ResearchFilter < ApplicationRecord
      
      resourcify
      audited
  belongs_to :variable,:class_name => 'ResearchVariable', foreign_key: 'variable_id'
  belongs_to :filter,:class_name => 'ResearchVariable', foreign_key: 'filter_id'
  belongs_to :country, class_name: 'Geography',foreign_key: 'country_id',optional: true

  def filter_name
  	self.filter.name
  end

  def variable_name
  	self.variable.name
  end
end
