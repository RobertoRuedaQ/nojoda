module DisbursementsHelper

    def lumni_disbursement_hash disbursements, fields, options={}

      fields += ['adjusted_student_value']
      disbursements_hash = {}
      disbursements.each_with_index do |disbursement,index|
        active_request = should_have_active_request?(disbursement)
        disbursements_hash[index] = {}
        disbursements_hash[index][:has_active_living_expenses] =  has_active_living_expenses?(disbursement)
        disbursements_hash[index][:disbursement_timing_mismatch] = disbursement_timing_mismatch?(disbursement)
        disbursements_hash[index][:funding_option_id] = disbursement.funding_option_id
        show_tuition = options[:validate_funding_opportunity_decision].present? ? show_tuition_table(disbursement) : true
        show_living_expenses = options[:validate_funding_opportunity_decision].present? ? show_living_expenses_table(disbursement) : true
        disbursements_hash[index][:show_tuition_table] = show_tuition 
        disbursements_hash[index][:show_living_expenses_table] = show_living_expenses
        fields.each do |f|
          disbursements_hash[index][f.to_sym] = lumni_disbrusement_collection_tranlator disbursement, f, active_request
        end
        active_request = false if disbursement.status == 'active'
      end
      return disbursements_hash
    end

    def show_tuition_table(disbursement)
      disbursement.student_academic_information.funding_opportunity.show_tuition_table
    end

    def show_living_expenses_table(disbursement)
      disbursement.student_academic_information.funding_opportunity.show_living_expenses_table
    end


    def should_have_active_request?(disbursement)
      disbursement.disbursement_case == "tuition" || has_active_living_expenses?(disbursement) || disbursement_timing_mismatch?(disbursement) || disbursement.disbursement_case == "emergency_living_expenses"
    end

    def has_active_living_expenses?(disbursement)
      disbursement.disbursement_case == 'living_expenses' && active_living_expenses?(disbursement)
    end

    def disbursement_periodicity(disbursement)
      if disbursement.student_academic_information.present?
        disbursement.student_academic_information.disbursements_periodicity
      end
    end

    def funding_opportunity_disbursement_periodicity(disbursement)
      if disbursement.student_academic_information.present?
        disbursement.student_academic_information.funding_opportunity.funding_disbursement.living_expenses_periodicity
      end
    end

    def disbursement_timing_mismatch?(disbursement)
      return false unless funding_opportunity_disbursement_periodicity(disbursement).present?
      disbursement_periodicity(disbursement) != funding_opportunity_disbursement_periodicity(disbursement)
    end

    def lumni_disbrusement_collection_tranlator disbursement, field, active_request
    	result = nil

    	case field
    	when 'student_value'
    		result = disbursement.student_value
    	when 'forcasted_date'
    		result = disbursement.forcasted_date
    	when 'activate'
    		result = disbursement_activate_button disbursement, field
    	when 'request'
    		result = set_student_disbursement_request_button disbursement, active_request
    	when 'disbursement_case'
    		result = disbursement.disbursement_case
    	when 'status'
    		result = disbursement.status
        when 'id'
            if current_user.student?
                result = disbursement.id
            else
                result = link_to disbursement.send(field),edit_disbursement_path(disbursement), class: 'text-primary', target: :blank
            end
        else
            result = disbursement.send(field)
    	end
    	return result
    end

    def disbursement_activate_button disbursement, field
        result = ''
        case disbursement.status
        when 'approved'
            result = content_tag :div, I18n.t('list.approved'), class: 'text-success'
        when 'generated'
            result = button_to I18n.t('general.activate'),activate_disbursement_path(disbursement), class: 'btn btn-sm btn-primary'
        when 'active'
            result = content_tag :div, I18n.t('list.active'), class: 'text-success'
        when 'requesting'
            result = content_tag :div, I18n.t('general.requesting'), class: 'text-secondary '
        end
        return result
    end

    def previous_disbursement_already_payed(disbursement)
      if disbursement.disbursement_number == 1 || disbursement == first_living_expenses_disbursement?(disbursement)
        true
      elsif disbursement.disbursement_number > 1
        previous_disbursement_payed?(disbursement) ? true : false
      end
    end

    def previous_disbursement_payed?(disbursement)
        disbursement.active_funding_option.disbursement.where(disbursement_case: disbursement.disbursement_case, disbursement_number: disbursement.disbursement_number - 1, status: 'payed').any?
    end

    def first_living_expenses_disbursement?(disbursement)
      disbursement.active_funding_option.disbursement.where(disbursement_case: "living_expenses").order(disbursement_number: :asc).first
    end

    def lumni_disbursement_table_translator disbursement, field

    	puts disbursement.to_s
    	result = nil
    	case field.to_s
    	when 'forcasted_date'
    		result = lumni_short_date disbursement[:forcasted_date]
    	when 'student_value','requested', 'disbursed','disbursement_process', 'compromised', 'available', 'approved', 'company_value', 'canceled','adjusted_student_value'
    		result = lumni_currency disbursement[field.to_sym].to_f
        when 'disbursement_case'
            result = I18n.t("application.#{disbursement[field]}")
        when 'stored_general_status'
            result = I18n.t('list.' + disbursement[field.to_sym])
        when 'disbursement_payment_support'
            if disbursement[:id]
                d = Disbursement.find(disbursement[:id])
                target_urls = d.disbursement_payment_support
                result = target_urls == 'n/a' ? I18n.t('list.unavailable') : link_to(I18n.t('list.payment_support'), url_for(target_urls.first))
            end
        else
    		result = disbursement[field]
    	end
    	return result
    end

    def set_student_disbursement_request_button disbursement,active_request
        result = nil
        case disbursement.status
        when 'generated'
            result = content_tag :div, I18n.t('list.inactive'), class: 'text-secondary '
        when 'active'
            if active_request && previous_disbursement_already_payed(disbursement)
                result = button_to I18n.t('disbursement.request_disbursement'), request_disbursement_disbursement_request_path(disbursement), class: 'btn btn-sm btn-primary', data: { disable_with: I18n.t('disbursement.processing') }
            else
                result = content_tag :div, I18n.t('list.inactive'), class: 'text-secondary '
            end
        when 'requesting'
            if !disbursement.current_application.nil?
                result = link_to I18n.t('disbursement.view_request'), edit_application_path(disbursement.current_application), class: 'btn btn-sm btn-primary', data: { disable_with: I18n.t('disbursement.processing') }
            else
                result = content_tag :div, I18n.t('application.under_review'), class: 'text-secondary '
            end
        when 'payed'
            if disbursement.pending_after_disbursement_cancellation? && !disbursement.cancellation_under_review?
                result = link_to I18n.t('disbursement.request_cancellation'), activate_disbursement_cancellation_application_disbursement_path(disbursement), class: 'btn btn-sm btn-warning'
            elsif disbursement.cancellation_under_review?
                result = ''
            end
        end
        return result

    end

    def lumni_disbursement_not_display
    	[:case,:currency,:adjusted_student_value, :status, :has_active_living_expenses, :disbursement_timing_mismatch, :funding_option_id, :show_tuition_table, :show_living_expenses_table]
    end

    def disbursement_hash_keys(disbursement_hash)
      disbursement_hash.first.keys
    end

    def active_living_expenses?(disbursement)
      disbursement.student_academic_information.funding_opportunity.active_living_expenses
    end

    def disbursement_target_columns(disbursement_hash, current_user, disbursement_case, funding_option_application_case, funding_option_id)
      columns = disbursement_hash_keys(disbursement_hash) - lumni_disbursement_not_display
      if current_user.student?
        columns -= [:company_value]
        if (disbursement_case == 'living_expenses' && disbursement_hash.first[:has_active_living_expenses] == false)
          columns -= [:request] unless disbursement_hash.first[:disbursement_timing_mismatch] == true
        elsif disbursement_case == 'tuition'
          columns += [:disbursement_payment_support]
        end
      end
      funding_option = funding_option_id.present? ? FundingOption.cached_find(funding_option_id) :nil
      if funding_option.present?
        if funding_option.application.remodeling? && funding_option.isa.nil?
          columns -= [:student_value]
          columns += [:adjusted_student_value]
        end
      end
      return columns
    end

    def funding_opportunity_without_active_living_expenses_request?(current_user)
      current_user.funded_programs.first.funding_opportunity.active_living_expenses == false
    end


end
