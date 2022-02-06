class RateCapUpdate < ApplicationRecord
  resourcify
  
  belongs_to :responsible, class_name: "User", foreign_key: "responsible_id"
end
