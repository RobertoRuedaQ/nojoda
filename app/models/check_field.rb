class CheckField < ApplicationRecord
      
      resourcify
      audited
      belongs_to :check_object
      has_many :check_mode, dependent: :destroy

      def self.progress
      	self.where(status: 'migrated').count
      end

end
