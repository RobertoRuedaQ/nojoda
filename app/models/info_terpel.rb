class InfoTerpel < ApplicationRecord
      
      resourcify
      audited
      belongs_to :user,touch: true



    has_one_attached :certificado_laboral

end
