class ApplicationCommittee < ApplicationRecord
      
      resourcify
      audited
  belongs_to :invest_committee
  belongs_to :application
end
