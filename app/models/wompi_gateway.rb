class WompiGateway < ApplicationRecord    
	resourcify
	audited

	belongs_to :company
  has_many :fund, as: :payment_gateway

	def start_transaction payment_info, billing_document,ip_address, gateway
    new_transaction = WompiTransaction.create(
			payment_method: payment_info.payment_method, 
			value: payment_info.value,  
			base: payment_info.base, 
			tax: payment_info.tax, 
			billing_document_id: billing_document.id, 
			ip_address: ip_address,
			wompi_gateway_id: gateway.id
		)
    new_transaction.reload
  end

	def generate_payment_structure(transaction, billing_document, payment_info, sync_url_notification, async_url_notification)
		value_to_pay = transaction.value * 100
		tax_to_pay = transaction.tax.present? ? (transaction.tax * 100) : 0
		{
			currency: billing_document.currency,
			amountInCents: value_to_pay.to_f,
			reference: transaction.external_id,
			publicKey: self.public_key,
			redirectUrl: sync_url_notification,
			taxInCents: {
				vat: tax_to_pay.to_f
			}
		}
	end


	def get_pse_bank_list
		begin
			response = RestClient::Request.execute(
				method: :get, url: ("#{self.wompi_url}/pse/financial_institutions"),
				headers: {Authorization: "Bearer #{self.public_key}"}
			)
			response.force_encoding("UTF-8")
			result = JSON.parse(response.body)['data']

			return result
		rescue StandardError => e
			puts e
		end
	end

	def get_wompi_transaction(payment_info, billing_document, transaction, sync_url_notification)
		begin 
			structure = if payment_info.payment_method == 'PSE'
										generate_pse_structure(payment_info, billing_document, transaction, sync_url_notification)
									else
										generate_bancolombia_collect_structure(payment_info, billing_document, transaction, sync_url_notification)
									end
			
			response = RestClient::Request.execute(
				method: :post, url: ("#{self.wompi_url}/transactions"),
				headers: {Authorization: "Bearer #{self.public_key}"},
				payload: structure.to_json
			)
			response.force_encoding("UTF-8")
			result = JSON.parse(response.body)['data']
	
			return result
		rescue StandardError => e
			puts JSON.parse(e.response)
		end
	end

	def generate_pse_structure(payment_info, billing_document, transaction, sync_url_notification)
		value_to_pay = transaction.value * 100
		tax_to_pay = transaction.tax.present? ? (transaction.tax * 100) : 0
		{
			"acceptance_token": payment_info.security_code,
			"amount_in_cents": value_to_pay.to_i,
			"currency": "COP",
			"customer_email": I18n.transliterate(payment_info.payer_email.to_s),
			"reference": transaction.external_id,
			'redirect_url': sync_url_notification,
			"payment_method": {
				"type": "PSE",
				"user_type": payment_info.user_type, # Tipo de persona, natural (0) o jurídica (1)
				"user_legal_id_type": payment_info.payer_dni_type, # Tipo de documento, CC o NIT
				"user_legal_id": payment_info.payer_dni_number, # Número de documento
				"financial_institution_code": payment_info.financial_institution, # Código (`code`) de la institución financiera
				"payment_description": ("Pago documento de cobro #{billing_document.id}")
			},
			"customer_data": {
				"phone_number": payment_info.payer_phone,
				"full_name": payment_info.payer_full_name
			}
		}
	end

	def generate_bancolombia_collect_structure(payment_info, billing_document, transaction, sync_url_notification)
		value_to_pay = transaction.value * 100
		tax_to_pay = transaction.tax.present? ? (transaction.tax * 100) : 0
		{
			"acceptance_token": payment_info.security_code,
			"amount_in_cents": value_to_pay.to_i,
			"currency": "COP",
			"reference": transaction.external_id,
			'redirect_url': sync_url_notification,
			'customer_email': I18n.transliterate(transaction.user_email.to_s),
			"payment_method": {
				"type": "BANCOLOMBIA_COLLECT",
				"sandbox_status": 'DECLINED'
			}
		}
	end

	def find_wompi_transaction_by_id(id)
		begin
			response = RestClient::Request.execute(
				method: :get, url: ("#{self.wompi_url}/transactions/#{id}"),
				headers: {Authorization: "Bearer #{self.public_key}"}
			)
			response.force_encoding("UTF-8")
			result = JSON.parse(response.body)['data']

			return result
		rescue StandardError => e
			puts e
		end
	end

	def create_acceptance_token
		begin
			response = RestClient::Request.execute(
				method: :get, url: ("#{self.wompi_url}/merchants/#{self.public_key}"),
				headers: {Authorization: "Bearer #{self.public_key}"}
			)
			response.force_encoding("UTF-8")
			result = JSON.parse(response.body)['data']['presigned_acceptance']
			
			return result
		rescue StandardError => e
			puts e
		end
	end

	def wompi_url
		if self.gateway_case == 'Production'
			'https://production.wompi.co/v1'
		else
			'https://sandbox.wompi.co/v1'
		end
	end
end
