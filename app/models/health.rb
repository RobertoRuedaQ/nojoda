class Health < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user, touch: true


  has_one_attached :health_ranking_certificate
  has_one_attached :health_coverage_certificate
end
