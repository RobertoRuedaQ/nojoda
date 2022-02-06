module DisbursementPaymentsHelper

	def disbursement_payment_index_header
		disbursement_payment_index_fields.map{| field| disbursement_payment_index_header_traslator field}
	end

	def disbursement_payment_index_rows payments
		result = []
		payments.each do |payment|
			result += [disbursement_payment_index_fields.map{| field| disbursement_payment_index_row_traslator payment, field}]
		end
		return result
	end

	def disbursement_payment_index_fields
		['disbursement_id','value','status']
	end

	def disbursement_payment_index_header_traslator field
		case field
		when 'disbursement_id'
			result = DisbursementPayment.human_attribute_name('id')
		else
			result = DisbursementPayment.human_attribute_name(field)
		end
	end

	def disbursement_payment_index_row_traslator payment, field
		case field
		when 'disbursement_id'
			result = link_to payment.send(field), edit_disbursement_path(payment.disbursement_id), class: 'text-primary'
		when 'status'
			result = I18n.t('list.' + payment.send(field))
		when 'value'
			result = lumni_currency payment.send(field), payment.disbursement.currency
		else
			result = payment.send(field)
		end
	end
end
