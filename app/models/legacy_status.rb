class LegacyStatus < ApplicationRecord
      
      resourcify
      audited
      #not using belong becase not all users have been migrated
      #belongs_to :user, class_name: 'User', foreign_key: 'external_id'

      def user
      	User.find_by_external_id(self.external_id)
      end

end
