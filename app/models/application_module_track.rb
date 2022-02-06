class ApplicationModuleTrack < ApplicationRecord
      
    resourcify
    audited      
belongs_to :application
belongs_to :origination_module

end