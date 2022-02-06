class StartingMailerAsync < ApplicationController
	include Sidekiq::Worker
	include LumniMigration
	include LumniRoles

	sidekiq_options queue: 'heavy_work'

	def perform
		require 'csv'    
		csv_text = open('https://lumnipublic.s3.amazonaws.com/expectativa1.csv').read
		csv = CSV.parse(csv_text, :headers => true)
		done_ids = CommunicationUser.where(subject: "Información Importante ").pluck(:user_id)

		csv.each_slice(20) do |users|
			users.each do |user|
				user = user.to_h
				values = user.values
				target_user = User.where.not(id: done_ids).find_by_email(values[1])
				if !target_user.nil?
					CommunicationMailer.invite_mail_without_token( values[2], target_user.company_id, values[1],user_id: target_user.id).deliver
				end
			end
			sleep 60
		end
	end
end