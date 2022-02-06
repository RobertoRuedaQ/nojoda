class EligibilityUsa < ApplicationRecord
    resourcify
  audited
  belongs_to :application
end
