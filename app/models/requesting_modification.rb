class RequestingModification < ApplicationRecord
      
      resourcify
      audited
  belongs_to :application
end
