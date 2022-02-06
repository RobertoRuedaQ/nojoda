module LumniMailer
  extend ActiveSupport::Concern
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper


  included do
    include Devise::Controllers::ScopedViews
  end

  protected

  attr_reader :scope_name, :resource



	def setLumniEmail communicationCase, user_id,opt={}

    user = User.cached_find(user_id) if !user_id.nil?
    targetLanguage = user_id.nil? ? nil : user.language
    puts "CommunicationCase: #{communicationCase}"
    puts "targetLanguage: #{targetLanguage}"
    if opt[:communication_id].nil?
      if !user.nil?
        @targetTemplate = CommunicationTemplate.includes(:communication_case).where(communication_cases: {title: communicationCase}, language: targetLanguage,status: 'active',discarded_at: nil, company_id: user.company_id)
        if @targetTemplate.count == 0
          @targetTemplate = CommunicationTemplate.includes(:communication_case).where(communication_cases: {title: communicationCase}, status: 'active',discarded_at: nil, company_id: user.company_id)
        end
        puts "Communication Filter 0"
      else
        @targetTemplate = []
      end

      if @targetTemplate.count == 0
  		  @targetTemplate = CommunicationTemplate.includes(:communication_case).where(communication_cases: {title: communicationCase}, language: targetLanguage,status: 'active',discarded_at: nil)
        puts "Communication Filter 1"
      end
        puts "Communication Filter 2"
      if @targetTemplate.count == 0
        puts "Communication Filter 3"
        @targetTemplate = CommunicationTemplate.includes(:communication_case).where(communication_cases: {title: communicationCase},status: 'active',discarded_at: nil).first
      else
      puts "Communication Filter 4"
        @targetTemplate = @targetTemplate.first
      end
    else
      @targetTemplate = CommunicationTemplate.cached_find(opt[:communication_id])
    end


		@targetHeader = @targetTemplate.communication_header
		@targetFooter = @targetTemplate.communication_footer
		@templateHTML = @targetHeader.body + @targetTemplate.body + @targetFooter.body
		@templateHTML = adjustTags(@templateHTML,user_id,opt)
	end

  def target_company_url company, target_url
    target_url.gsub! root_url.split('/').last, company.url
  end

	def adjustTags targetText,user_id, opt = {}
		if !user_id.nil?
			user = User.cached_find(user_id)
			targetText.gsub! '##name', user.name.to_s
			targetText.gsub! '##first_name', user.first_name.to_s
      targetText.gsub! '##last_name', user.last_name.to_s
      targetText.gsub! '##full_name', user.name.to_s
      if !user.personal_information.nil?
        targetText.gsub! '##identification_number', user.personal_information.identification_number.to_s
      end
      targetText.gsub! '##reset_password', "https://#{user.company.url}/users/password/new"

      targetText.gsub! '##phone_company', user.company.contact_info.phone.to_s
      targetText.gsub! '##email_company', user.company.contact_info.contact_email.to_s
      targetText.gsub! '##update_email', user.email.to_s
      if user.ongoing_application.present?
        targetText.gsub! '##close_date_opportunity', user.ongoing_application.funding_opportunity.close_date.to_s
        targetText.gsub! '##fund', user.ongoing_application.funding_opportunity.fund.name.to_s
      end

      if user.supporting_team.any?
        supervisor = user.supporting_team.first.supervisor

        targetText.gsub! '##supervisor_name', (supervisor.name || '')
        targetText.gsub! '##supervisor_phone', (supervisor&.contact_info&.phone || '')
        targetText.gsub! '##supervisor_mobile', (supervisor&.contact_info&.mobile || '')
        targetText.gsub! '##supervisor_email', (supervisor&.contact_info&.contact_email || '')
      end
		end

    if opt[:custom_message].present?
      targetText.gsub! '##custom_message', opt[:custom_message].to_s
    end

    if opt[:company_id].present?
      company = Company.cached_find(opt[:company_id])
      targetText.gsub! '##phone_company', company.contact_info.phone.to_s
      targetText.gsub! '##email_company', company.contact_info.contact_email.to_s
    end

    if opt[:billing_document_id].present?
      billing_document = BillingDocument.cached_find(opt[:billing_document_id])
      @billing_document = billing_document
      targetText.gsub! '##document_value', lumni_currency(billing_document.pending_value,billing_document.currency).to_s
      targetText.gsub! '##collection_document_url',target_company_url( billing_document.company, billing_document_url(billing_document)) 

    end

    if opt[:original_legal_document_id].present?
      legal_document = LegalDocument.cached_find(opt[:original_legal_document_id])
      targetText.gsub! '##legal_document_name', legal_document.name.to_s
      targetText.gsub! '##legal_document_body', legal_document.body.to_s.html_safe
      targetText.gsub! '##legal_document_validation', legal_document.validation.to_s
      targetText.gsub! '##jump_page', " <div class='alwaysbreak'> </div>"
    end


    if opt[:legal_document_id].present?
      legal_document = LegalMatch.cached_find(opt[:legal_document_id])
      targetText.gsub! '##legal_document_name', legal_document.legal_document.name.to_s
      targetText.gsub! '##legal_document_body', legal_document.body.to_s.html_safe
      targetText.gsub! '##legal_document_validation', legal_document.validation.to_s
    end

    if opt[:application_id].present?
      application = Application.cached_find(opt[:application_id])
      targetText.gsub! '##application_url', url_for([:edit, application])
    end

    if opt[:token_id].present?
      token = FundingToken.cached_find(opt[:token_id])
      targetText.gsub! '##name', token.name.to_s
      targetText.gsub! '##token', token.token.to_s
    end

    if opt[:disbursement_payment_id].present?
      disbursement_payment = DisbursementPayment.cached_find(opt[:disbursement_payment_id])
      targetText.gsub! '##payment_date', disbursement_payment.payment_date.to_s
      targetText.gsub! '##payment_amount', lumni_currency(disbursement_payment.value.to_s, disbursement_payment.disbursement.isa.currency)
      targetText.gsub! '##bank_account_number', disbursement_payment.bank_account.account_number.to_s
      targetText.gsub! '##bank_account_bank_name', disbursement_payment.bank_account.bank_name.to_s
    end

		targetText
	end


  def lumni_mail_settings(user_id,subject,opt={})
    user = User.cached_find(user_id) if !user_id.nil?
    target_email = opt[:target_email].nil? ? user.email : opt[:target_email]

    headers = {
      subject: subject,
      to: target_email,
      from: mailer_sender(devise_mapping),
      reply_to: mailer_reply_to(devise_mapping)
    }

    @email = headers[:to]
    headers
  end


  # Configure default email options
  def devise_mail(record, action, opts = {}, &block)
    initialize_from_record(record)
    mail headers_for(action, opts), &block
  end

  def initialize_from_record(record)
    @scope_name = Devise::Mapping.find_scope!(record)
    @resource   = instance_variable_set("@#{devise_mapping.name}", record)
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[scope_name]
  end

  def headers_for(action, opts)
    headers = {
      subject: subject_for(action),
      to: resource.email,
      from: mailer_sender(devise_mapping),
      reply_to: mailer_reply_to(devise_mapping),
      template_path: template_paths,
      template_name: action
    }.merge(opts)

    @email = headers[:to]
    headers
  end

  def mailer_reply_to(mapping)
    mailer_sender(mapping, :reply_to)
  end

  def mailer_from(mapping)
    mailer_sender(mapping, :from)
  end

  def mailer_sender(mapping, sender = :from)
    default_sender = default_params[sender]
    if default_sender.present?
      default_sender.respond_to?(:to_proc) ? instance_eval(&default_sender) : default_sender
    elsif Devise.mailer_sender.is_a?(Proc)
      Devise.mailer_sender.call(mapping.name)
    else
      Devise.mailer_sender
    end
  end

  def template_paths
    template_path = "devise/mailer" 
  end

  # Set up a subject doing an I18n lookup. At first, it attempts to set a subject
  # based on the current mapping:
  #
  #   en:
  #     devise:
  #       mailer:
  #         confirmation_instructions:
  #           user_subject: '...'
  #
  # If one does not exist, it fallbacks to ActionMailer default:
  #
  #   en:
  #     devise:
  #       mailer:
  #         confirmation_instructions:
  #           subject: '...'
  #
  def subject_for(key)
    I18n.t(:"#{devise_mapping.name}_subject", scope: [:devise, :mailer, key],
      default: [:subject, key.to_s.humanize])
  end
end
