class CheckObject < ApplicationRecord
      
      resourcify
      audited


      scope :clean, ->(){includes(:check_field).where('rows > 0').where.not("name LIKE '%History'").where.not("name LIKE '%Share'")}

      has_many :check_field, dependent: :destroy


end
