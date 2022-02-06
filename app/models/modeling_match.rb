class ModelingMatch < ApplicationRecord
  
  resourcify
  audited
  belongs_to :application
  belongs_to :resource, polymorphic: true
  validates_uniqueness_of :application_id
end
