class DeviseMailer < ApplicationMailer

    include LumniMailer


    def confirmation_instructions(record, token, opts={})
    	@templateHTML = setLumniEmail('confirmation_email',record.id)
      initialize_from_record(record)
      action = :confirmation_instructions
      @token = token
      make_bootstrap_mail(headers_for(action, opts))
    end

    def reset_password_instructions(record, token, opts={})
      @templateHTML = setLumniEmail('reset_password',record.id)
      initialize_from_record(record)
      action = :reset_password_instructions
      @token = token
      make_bootstrap_mail(headers_for(action, opts))
    end

    def unlock_instructions(record, token, opts={})
      @templateHTML = setLumniEmail('unlock_account',record.id)
      initialize_from_record(record)
      action = :unlock_instructions
      @token = token
      make_bootstrap_mail(headers_for(action, opts))
    end

    def email_changed(record, opts={})
      @templateHTML = setLumniEmail('modify_email',record.id)
    	initialize_from_record(record)
    	action = :email_changed
      @token = token
      make_bootstrap_mail(headers_for(action, opts))
    end

    def password_change(record, opts={})
      @templateHTML = setLumniEmail('successful_password_change',record.id)
    	initialize_from_record(record)
    	action = :password_change
      @token = token
      make_bootstrap_mail(headers_for(action, opts))
    end

end
