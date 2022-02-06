require 'mercadopago'

class MercadoPagoGateway < ApplicationRecord
      
	resourcify
	audited
	belongs_to :company
  has_many :fund, as: :payment_gateway


	def start_transaction payment_info, billing_document,ip_address
    new_transaction = MercadoPagoTransaction.create(
			payment_method: payment_info.payment_method, 
			value: payment_info.value,  
			base: payment_info.base, 
			tax: payment_info.tax, 
			billing_document_id: billing_document.id, 
			ip_address: ip_address, 
			mercado_pago_gateway_id: billing_document.gateway.id
		)
    new_transaction.reload
  end

	def create_preference(transaction, billing_document, payment_info, sync_url_notification, async_url_notification)
		begin 
			preference_data = generate_preference_structure(transaction, billing_document, payment_info, sync_url_notification, async_url_notification)
			preference_response = sdk_connector.preference.create(preference_data)
			preference = preference_response[:response]
			return preference['id']
		rescue StandardError => e
			puts e
		end
	end

	def get_payment_by_id(payment_id)
		return sdk_connector.payment.get(payment_id)
	end


	def generate_preference_structure(transaction, billing_document, payment_info, sync_url_notification, async_url_notification)
		external_reference = transaction.external_id
		if billing_document.isa
			fund = billing_document.isa.fund
			external_reference = "#{fund.id}_#{fund.name.parameterize.underscore}"
		end
		{
			"items": [
				{
					"id": transaction.external_id,
					"title": billing_document.description,
					"currency_id": billing_document.currency,
					"picture_url": "https://www.mercadopago.com/org-img/MP3/home/logomp3.gif",
					"description": billing_document.description,
					"quantity": 1,
					"unit_price": transaction.value.to_f
				}
			],
			"payer": {
				"name":  @demo_name.nil? ? I18n.transliterate(payment_info.payer_full_name.to_s) : @demo_name,
				"email": I18n.transliterate(payment_info.payer_email.to_s),
				"phone": {
					"area_code": "00",
					"number": I18n.transliterate(payment_info.payer_phone.to_s)
				}
			},
			"back_urls": {
				"success": sync_url_notification,
				"failure": sync_url_notification,
				"pending": sync_url_notification
			},
			"auto_return": "approved",
			"payment_methods": {
				"excluded_payment_types": generate_excluded_payment_types_strcture(transaction)
			},
			"statement_descriptor": "Lumni",
			"external_reference": external_reference,
			"notification_url": async_url_notification,
			"taxes": [
				{
					"type": "IVA",
					"value": transaction.tax.to_f
				}
			]
		}
	end

	def generate_excluded_payment_types_strcture(transaction)
		excluded = excluded_payment_types(transaction)
		a = []
		excluded.each do |method|
			a << { 'id': method }
		end

		return a
	end

	def excluded_payment_types(transaction)
		m_type = allowed_payments_type
		m_type.reject{ |method| (method == transaction.payment_method || method == 'account_money') }
	end

	def allowed_payments_type
		['ticket', 'bank_transfer', 'debit_card', 'credit_card', 'account_money', 'atm', 'prepaid_card', 'digital_wallet', 'digital_currency']
	end



	private

	def sdk_connector
		@connector ||= Mercadopago::SDK.new(self.access_token)
	end
end
