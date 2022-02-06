class ContactInfo < ApplicationRecord
    resourcify
  audited

	belongs_to :resource, polymorphic: true,touch:true
	belongs_to :user, ->(){joins(:contact_info).where(contact_infos: {resource_type: 'User'}).kept},class_name: 'User',foreign_key: 'resource_id',optional: true


	def email_required?
	  false
	end

	def password_changed?
	  false
	end

	def origination
		self.user.funds.first.student_contact_information_origination
	end
	
end
