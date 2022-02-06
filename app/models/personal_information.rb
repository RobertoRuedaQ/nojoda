class PersonalInformation < ApplicationRecord
  resourcify
  audited

  belongs_to :user

	has_one_attached :birth_certificate
	has_one_attached :identification_document_image
	has_one_attached :military_passbook_image
	has_one_attached :criminal_record_certificate
	has_one_attached :civil_registry
	has_one_attached :rfc_support
	has_one_attached :curp_support

	after_commit :sync_identification_number


	def sync_identification_number
		if self.identification_number != self.user.identification_number
			self.user.update(identification_number: self.identification_number)
		end
	end

	def origination
		self.user.funds.first.student_personal_information_origination
	end



end
