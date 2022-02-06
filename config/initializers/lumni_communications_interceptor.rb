class LumniCommunicationsInterceptor
  def self.delivering_email(message)
  	target_user = User.joins(:contact_info).where(email: message.smtp_envelope_to).or( User.joins(:contact_info).where(contact_infos: {secondary_email: message.smtp_envelope_to}))
  	target_user.each do |user|
	  	CommunicationUser.create({to_field: message.smtp_envelope_to, from_field:message.smtp_envelope_from,subject: message.subject,body: message.html_part.body.decoded,read_field: false,user_id: user.id})
	  end
  end
end



ActionMailer::Base.register_interceptor(LumniCommunicationsInterceptor)
