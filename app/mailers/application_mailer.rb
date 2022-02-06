class ApplicationMailer < ActionMailer::Base
	add_template_helper(ApplicationHelper)
	require 'sendgrid-ruby'
	include SendGrid
	# require 'gibbon'

	layout 'mailer'
end
