class CommunicationMailer < ApplicationMailer
  include LumniMailer

  def legal_document_mail user_id, legal_document_id
  	@user = User.cached_find(user_id)
  	@legal_document = LegalMatch.cached_find(legal_document_id)
  	@templateHTML = setLumniEmail('legal_document',user_id,legal_document_id: legal_document_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject,user_id,legal_document_id: legal_document_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def resend_communication_user communication_user_id
    @communication_user = CommunicationUser.find(communication_user_id)
    mail( :to => eval(@communication_user.to_field),
    :subject => @communication_user.subject )
  end

  def invite_mail_with_token communication_id, token_id, company_id
  	@communication = CommunicationTemplate.cached_find(communication_id)
  	@templateHTML = setLumniEmail('invite_mail',nil, communication_id: communication_id,token_id: token_id,company_id: company_id)
  	token = FundingToken.cached_find(token_id)
    make_bootstrap_mail(lumni_mail_settings(nil,adjustTags(@targetTemplate.subject,nil),target_email: token.target_email)
    )
  end

  def invite_mail_without_token communication_id, company_id, email, options={}

    @communication = CommunicationTemplate.cached_find(communication_id)

    @templateHTML = setLumniEmail('invite_mail',options[:user_id], communication_id: communication_id,company_id: company_id)

    make_bootstrap_mail(lumni_mail_settings(options[:user_id],adjustTags(@targetTemplate.subject,nil),target_email: email)
    )
  end



  def students_activation email,user_id
    communication_id = 166

    @communication = CommunicationTemplate.cached_find(communication_id)

    @templateHTML = setLumniEmail('student_activation',user_id, communication_id: communication_id,reset_password: true)

    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject,user_id),target_email: email)
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end




  def activating_isa_email user_id, company_id
    @templateHTML = setLumniEmail('activating_contract_after_test_period',user_id,company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject,user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def general_application_communication user_id, application_id, company_id, target_communication_name
    @templateHTML = setLumniEmail(target_communication_name,user_id,company_id: company_id, application_id: application_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject,user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end



  def billing_document_email user_id, company_id, billing_document_id
    @templateHTML = setLumniEmail('collection_document',user_id,company_id: company_id,billing_document_id: billing_document_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject,user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end


  def request_review_correction user_id, company_id, custom_message
    @templateHTML = setLumniEmail('request_correction',user_id,company_id: company_id, custom_message: custom_message)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject,user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end


  def send_preview legal_document_id, email
    @legal_document = LegalDocument.cached_find(legal_document_id)
    @templateHTML = setLumniEmail('legal_document',nil,original_legal_document_id: legal_document_id)
    make_bootstrap_mail(lumni_mail_settings(nil,adjustTags(@targetTemplate.subject,nil,original_legal_document_id: legal_document_id),target_email: email)
    )
  end



  def reapply communication_id, email
    @templateHTML = setLumniEmail('reapply',nil, communication_id: communication_id)
    make_bootstrap_mail(lumni_mail_settings(nil,adjustTags(@targetTemplate.subject,nil),target_email: email)
    )
  end

  def request_diploma_delivery user_id, company_id
    @templateHTML = setLumniEmail('request_diploma_delivery', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def notify_disbursement_payment user_id, company_id
    @templateHTML = setLumniEmail('notify_disbursement_payment', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def notify_living_expenses_disbursement_payment user_id, company_id, disbursement_payment_id
    @templateHTML = setLumniEmail('notify_living_expenses_disbursement_payment', user_id, company_id: company_id, disbursement_payment_id:disbursement_payment_id )
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def reminder_complete_pending_application_disbursement user_id, company_id, application_id
    @templateHTML = setLumniEmail('reminder_complete_pending_application_disbursement', user_id, company_id: company_id, application_id: application_id )
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def no_continuity_postulation(user_id, company_id)
    @templateHTML = setLumniEmail('no_continuity_postulation', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def continuity_postulation(user_id, company_id)
    @templateHTML = setLumniEmail('continuity_postulation', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def no_continuity_postulation_black_rock(user_id, company_id)
    @templateHTML = setLumniEmail('no_continuity_postulation_black_rock', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def continuity_postulation_black_rock(user_id, company_id)
    @templateHTML = setLumniEmail('continuity_postulation_black_rock', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def emergency_black_rock(user_id, company_id)
    @templateHTML = setLumniEmail('emergency_black_rock', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def mentory_and_empleability(user_id, company_id)
    @templateHTML = setLumniEmail('mentory_and_empleability', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def mentory_acceptance(user_id, company_id)
    @templateHTML = setLumniEmail('mentory_acceptance', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def empleability_acceptance(user_id, company_id)
    @templateHTML = setLumniEmail('empleability_acceptance', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def mentory_and_empleability_acceptance(user_id, company_id)
    @templateHTML = setLumniEmail('mentory_and_empleability_acceptance', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end

  def mentory_and_empleability_rejection(user_id, company_id)
    @templateHTML = setLumniEmail('mentory_and_empleability_rejection', user_id, company_id: company_id)
    make_bootstrap_mail(lumni_mail_settings(user_id,adjustTags(@targetTemplate.subject, user_id))
    )
    create_communication_user(user_id, @targetTemplate, @templateHTML)
  end


  def create_communication_user(user_id, targetTemplate, templateHTML)
    CreateRecordAsync.perform_async('communication_user', {user_id: user_id, from_field: "no-reply@lumni.net", subject: targetTemplate.subject, body: templateHTML})
  end


end
