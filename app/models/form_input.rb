class FormInput < ApplicationRecord
      
      resourcify
      audited
  belongs_to :form_field
end
