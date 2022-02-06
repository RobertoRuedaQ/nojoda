class PayuGateway < ApplicationRecord
  # ["AMEX", "VISA", "DINERS", "CODENSA", "VISA_DEBIT", "PSE", "OTHERS_CASH", "LENDING_INSTALLMENTS", "MASTERCARD", "BANK_REFERENCED", "EFECTY", "ACH_DEBIT", "BALOTO", "PAGOEFECTIVO", "MASTERCARD_DEBIT", "SEVEN_ELEVEN", "OXXO", "OTHERS_CASH_MX", "SPEI", "ELO", "NARANJA", "CMR", "CABAL", "SHOPPING", "CENCOSUD", "PAGOFACIL", "BCP", "HIPERCARD", "RIPSA", "ARGENCARD", "BAPRO", "DISCOVER", "BOLETO_BANCARIO", "CASH_ON_DELIVERY", "TRANSBANK_DEBIT", "MASTERPASS", "MULTICAJA", "RAPIPAGO", "COBRO_EXPRESS"]      
      resourcify
      audited
  belongs_to :company
  has_many :fund, as: :payment_gateway
  has_many :payu_transaction, dependent: :destroy

  after_commit :flush_payu_cache

  def flush_payu_cache
    Rails.cache.delete([self.id,'cached_payment_method_names'])
  end


  def cached_payment_methods
    Rails.cache.fetch(['cached_payment_methods',self.id],expires_in: 1.day){payment_methods_array}
  end

  def payment_methods_array
    self.active_payment_methods["paymentMethods"].map{|i| i["description"] }
  end

  def active_payment_methods
    target_params = {
       "test": false,
       "language": "en",
       "command": "GET_PAYMENT_METHODS",
       "merchant": {
          "apiLogin": self.api_login,
          "apiKey": self.api_key
       }
    }
    self.get_payu_answer(target_params)
  end


  def active_payment_methods_names
    payment_methods = self.active_payment_methods
    payment_methods['paymentMethods'].map{|p| p['description'] if p['enabled']}.compact.uniq
  end

  def cached_payment_method_names
    Rails.cache.fetch([self.id,'cached_payment_method_names'],expires_in: 1.days){active_payment_methods_names}
  end

  
  def cash_on_delivery_method
    # This is just to have all options listed. We don't deliver, so, is useless.
    ["CASH_ON_DELIVERY"]
  end
  def ach_methods
    ["ACH_DEBIT"]
  end

  def cards_methods
    debit_cards_methods + credit_card_methods
  end

  def debit_cards_methods
    ["VISA_DEBIT","MASTERCARD_DEBIT"]
  end

  def bank_transfers_methods
    ["PSE", "SPEI","TRANSBANK_DEBIT"]
  end

  def credit_card_methods
    ["AMEX", "VISA", "DINERS", "CODENSA","LENDING_INSTALLMENTS", "MASTERCARD","ELO","CABAL", "SHOPPING", "CENCOSUD", "ARGENCARD", "HIPERCARD","NARANJA", "DISCOVER","CMR","MASTERPASS" ]
  end

  def cash_methods
    [ "EFECTY", "OTHERS_CASH","BALOTO", "PAGOEFECTIVO", "SEVEN_ELEVEN", "OXXO", "OTHERS_CASH_MX","BANK_REFERENCED","RAPIPAGO", "COBRO_EXPRESS", "BOLETO_BANCARIO", "MULTICAJA","BCP", "PAGOFACIL","RIPSA", "BAPRO"]
  end

  def supported_cash
    self.cached_payment_method_names & cash_methods
  end

  def supported_debit
    self.cached_payment_method_names & debit_cards_methods
  end

  def supported_credit
    self.cached_payment_method_names & credit_card_methods
  end

  def supported_transfers
    self.cached_payment_method_names & bank_transfers_methods
  end

  def supported_ach
    self.cached_payment_method_names & ach_methods
  end



  def get_credit_cards_supported
    credit_card_names & self.cached_payment_method_names
  end

  def get_id_types_supported
    { 'Cédula de ciudadanía' => 'CC', 'Cédula de extranjería' => 'CE', 'NIT' => 'NIT',
      'Tarjeta de Identidad' => 'TI', 'Pasaporte' => 'PP', 'Identificador único de cliente' => 'IDC',
      'Línea del móvil' => 'CEL', 'Registro civil de nacimiento' => 'RC', 'Documento de identificación extranjero' => 'DE'}
  end

  def get_customer_types_supported
    { 'Persona natural' => 'N', 'Persona jurídica' => 'J' }
  end

  def get_cash_methods_supported(value)
    franchises = {}
    franchises['BALOTO'] = 'BALOTO' if value >= 9960 && value <= 1000000
    franchises['EFECTY'] = 'EFECTY' if value >= 20000 && value <= 3000000
    franchises['BCP'] = 'BCP' if value >= 9 && value <= 4923
    franchises['PAGO EFECTIVO'] = 'PAGOEFECTIVO' if value >= 9 && value <= 16750
    franchises['OXXO'] = 'OXXO' if value >= 52 && value <= 26156
    franchises['BANCOMER'] = 'BANCOMER' if value >= 52 && value <= 26156
    franchises['SCOTIABANK'] = 'SCOTIABANK' if value >= 52 && value <= 26156
    franchises['SANTANDER'] = 'SANTANDER' if value >= 52 && value <= 26156
    franchises['7ELEVEN'] = 'SEVEN_ELEVEN' if value >= 52 && value <= 26156
    franchises['OTROS MEDIOS EN EFECTIVO'] = 'OTHERS_CASH_MX' if value >= 52 && value <= 26156
    franchises
  end




  def get_debit_cards_supported
    if self.cached_payment_method_names.include?('PSE')
      target_params = {
          'language': 'es',
          'command': 'GET_BANKS_LIST',
          'merchant': {
              'apiLogin': "#{self.api_login}",
              'apiKey': "#{self.api_key}"
          },
          'test': false,
          'bankListInformation': {
              'paymentMethod': 'PSE',
              'paymentCountry': 'CO'
          }
      }
      response = self.get_payu_answer(target_params)
      result = response['banks'].map { |e| [e['description'], e['pseCode']] }
    else
      result = nil
    end
    return result
  end



  def get_payu_answer target_params
    response = RestClient::Request.execute(method: :post, url: self.url,
                                            :payload => target_params.to_json, timeout: Gateway::TIMEOUT_FOR_GATEWAY,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => true )
    response.force_encoding("UTF-8")
    result = JSON.parse(response.body)

    return result
  end


  def get_payu_report target_params
    if self.gateway_case == 'production'
      target_url = 'https://api.payulatam.com/reports-api/4.0/service.cgi'
    else
      target_url = 'https://sandbox.api.payulatam.com/reports-api/4.0/service.cgi'
    end
    puts target_url
    response = RestClient::Request.execute(method: :post, url: target_url,
                                            :payload => target_params.to_json, timeout: Gateway::TIMEOUT_FOR_GATEWAY,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => true )
    response.force_encoding("UTF-8")
    result = JSON.parse(response.body)

    return result
  end



  def get_payu_response target_params, transaction
    target_response = self.get_payu_answer target_params
    result = PayuResponse.build_form_response target_response, transaction

    return result
  end


  def ping

  	if !['staging_webcheckout','webcheckout'].include?(self.gateway_case)
		target_params ={
		   "test": false,
		   "language": "en",
		   "command": "PING",
		   "merchant": {
		      "apiLogin": self.api_login,
		      "apiKey": self.api_key
		   }
		}
    response = self.get_payu_answer(target_params)
	else
		response = {'code' => 'SUCCESS'}
	end
	return response

  end

  def success?
  	begin
  		self.ping['code'] == 'SUCCESS'
  	rescue Exception => e
  		false
  	end
  end

  def error_message
  	begin
  		self.ping['error']
  	rescue Exception => e
  		e
  	end
  end

  def signature reference_code, value,currency
    data_for_signature = "#{self.api_key}~#{self.merchant_id}~#{reference_code}~#{value}~#{currency}"
    puts "Data for signature: #{data_for_signature}"
    signature = Digest::MD5.hexdigest(data_for_signature)
  end

  def start_transaction payment_info, billing_document,ip_address
    new_transaction = PayuTransaction.create(payment_method: payment_info.payment_method, value: payment_info.value,  base: payment_info.base, tax: payment_info.tax,billing_document_id: billing_document.id,ip_address: ip_address,payu_gateway_id: billing_document.gateway.id)
    new_transaction.reload
  end

  def general_cash_hash_request transaction,billing_document,confirmation_url,payment_info
    splited_ip_address = confirmation_url.split('/') 
    target_params = {
       "language": "es",
       "command": "SUBMIT_TRANSACTION",
       "merchant": {
          "apiKey": self.api_key,
          "apiLogin": self.api_login
       },
       "transaction": {
          "order": {
             "accountId": self.account_id,
             "referenceCode": transaction.external_id,
             "description": billing_document.description,
             "language": "es",
             "signature": self.signature( transaction.external_id, transaction.value,billing_document.currency),
             "notifyUrl": confirmation_url,
             "additionalValues": {
                "TX_VALUE": {
                   "value": transaction.value.to_f,
                   "currency": billing_document.currency
             },
                "TX_TAX": {
                   "value": transaction.tax.to_f,
                   "currency": billing_document.currency
             },
                "TX_TAX_RETURN_BASE": {
                   "value": transaction.base.to_f,
                   "currency": billing_document.currency
             }
             },
             "buyer": {
                "fullName": billing_document.user_name,
                "emailAddress": billing_document.email
             }
          },
          "extraParameters": {
             "NETWORK_CALLBACK_URL": "#{splited_ip_address[0]}//#{splited_ip_address[2]}/billing_documents/#{billing_document.id}"
          },
          "payer": {
             "fullName": billing_document.user_name
          },
          "type": "AUTHORIZATION_AND_CAPTURE",
          "paymentMethod": transaction.payment_method,
          "expirationDate": Time.now.to_date + 15.days,
          "paymentCountry": billing_document.country.international_code,
          "ipAddress": payment_info.ip_address
       },
       "test": false
    }
    return target_params    
  end



  def cash_response transaction,billing_document,confirmation_url,payment_info
    splited_ip_address = confirmation_url.split('/') 
    general_hash = general_cash_hash_request transaction,billing_document,confirmation_url,payment_info
    target_params = general_hash

    case billing_document.currency
    when 'COP','CLP'
      additional_info = {
       "transaction": {
          "order": {
             "additionalValues": {
                "TX_VALUE": {
                   "value": transaction.value.to_f,
                   "currency": billing_document.currency
                },
                "TX_TAX": {
                   "value": transaction.tax.to_f,
                   "currency": billing_document.currency
                },
                "TX_TAX_RETURN_BASE": {
                   "value": transaction.base.to_f,
                   "currency": billing_document.currency
                }
             }
          }
       }
    }
    when 'PEN','ARS','MXN','USD'
      additional_info = {
         "transaction": {
            "order": {
               "additionalValues": {
                  "TX_VALUE": {
                     "value": transaction.value.to_f,
                     "currency": billing_document.currency
                  }
               }
            }
         }
      }
    end

    target_params[:transaction][:order] = general_hash[:transaction][:order].merge(additional_info[:transaction][:order])

    response = self.get_payu_response(target_params,transaction)
  end


  def general_card_hash_request transaction,billing_document,confirmation_url,payment_info


    {
     "language": "es",
     "command": "SUBMIT_TRANSACTION",
     "merchant": {
        "apiKey": self.api_key,
        "apiLogin": self.api_login
     },
     "transaction": {
        "order": {
           "accountId": self.account_id,
           "referenceCode": transaction.external_id,
           "description": billing_document.description,
           "language": "es",
           "signature": self.signature( transaction.external_id, transaction.value,billing_document.currency),
           "notifyUrl": confirmation_url,
           "buyer": {
              "merchantBuyerId": billing_document.user.id,
              "fullName": billing_document.user_name,
              "emailAddress": billing_document.email,
              "contactPhone": billing_document.mobile,
              "dniNumber": billing_document.identification_number,
              "shippingAddress": {
                 "street1": billing_document.address1,
                 "street2": billing_document.address2,
                 "city": billing_document.city,
                 "state": billing_document.state,
                 "country": billing_document.country_code,
                 "postalCode": billing_document.postal_code,
                 "phone": billing_document.mobile
              }
           },
        },
        "payer": {
           "merchantPayerId": billing_document.user.id,
           "fullName": I18n.transliterate(payment_info.payer_full_name.to_s),
           "emailAddress": I18n.transliterate(payment_info.payer_email.to_s),
           "contactPhone": I18n.transliterate(payment_info.payer_phone.to_s),
           "dniNumber": I18n.transliterate(payment_info.payer_dni_number.to_s),
           "billingAddress": {
              "street1": I18n.transliterate(payment_info.payer_address1.to_s),
              "street2": I18n.transliterate(payment_info.payer_address2.to_s),
              "city": I18n.transliterate(payment_info.payer_city.to_s),
              "state": I18n.transliterate(payment_info.payer_state.to_s),
              "country": I18n.transliterate(payment_info.payer_country.to_s),
              "postalCode": I18n.transliterate(payment_info.payer_postal_code.to_s),
              "phone": I18n.transliterate(payment_info.payer_phone.to_s)
           }
        },
        "creditCard": {
           "number": payment_info.card_number.to_s,
           "securityCode": payment_info.security_code.to_s,
           "expirationDate": "#{payment_info.expiration_year}/#{payment_info.expiration_month}",
           "name": I18n.transliterate(payment_info.card_name.to_s)
        },
        "extraParameters": {
           "INSTALLMENTS_NUMBER": payment_info.installments_number
        },
        "type": "AUTHORIZATION_AND_CAPTURE",
        "paymentMethod": payment_info.payment_method,
        "paymentCountry": billing_document.country_code,
        "deviceSessionId": Digest::MD5.hexdigest("#{payment_info.device_session_id}#{(Time.zone.now.to_f*1000).to_i.to_s}"),
        "ipAddress": payment_info.ip_address,
        "cookie": payment_info.device_session_id,
        "userAgent": payment_info.user_agent
     },
     "test": self.gateway_case == 'staging'
    }    
  end

  def card_response transaction,billing_document,confirmation_url,payment_info

    general_hash = general_card_hash_request(transaction,billing_document,confirmation_url,payment_info)
    target_params = general_hash
    case billing_document.currency
    when 'COP'
      additional_info = {
       "transaction": {
          "order": {
             "additionalValues": {
                "TX_VALUE": {
                   "value": transaction.value.to_f,
                   "currency": 'COP'
             },
                "TX_TAX": {
                   "value": transaction.tax.to_f,
                   "currency": 'COP'
             },
                "TX_TAX_RETURN_BASE": {
                   "value": transaction.base.to_f,
                   "currency": 'COP'
             }
            }
          }    
        }
      }
    when 'PEN'
      additional_info = {
       "transaction": {
          "order": {
             "additionalValues": {
                "TX_VALUE": {
                   "value": transaction.value.to_f,
                   "currency": "PEN"
                }
             }
          }
       }
    }
    when 'MXN'
      additional_info = {
         "transaction": {
            "order": {
               "additionalValues": {
                  "TX_VALUE": {
                     "value": transaction.value.to_f,
                     "currency": "MXN"
                  }
               }
            },
            "payer": {
               "birthdate": payment_info.birthday,
            }
         }
      }
      target_params[:transaction][:payer] = general_hash[:transaction][:payer].merge(additional_info[:transaction][:payer])
    end
    target_params[:transaction][:order] = general_hash[:transaction][:order].merge(additional_info[:transaction][:order])

    response = self.get_payu_response(target_params,transaction)

  end



  def get_pse_bank_list

    target_params = {
       "language": "es",
       "command": "GET_BANKS_LIST",
       "merchant": {
          "apiLogin": self.api_login,
          "apiKey": self.api_key
       },
       "test": false,
       "bankListInformation": {
          "paymentMethod": "PSE",
          "paymentCountry": "CO"
       }
    }
    response = self.get_payu_answer(target_params)  
  end


  def pse_request transaction,billing_document,confirmation_url,response_url,payment_info

    target_params = {
       "language": "es",
       "command": "SUBMIT_TRANSACTION",
       "merchant": {
          "apiKey": self.api_key,
          "apiLogin": self.api_login
       },
       "transaction": {
          "order": {
             "accountId": self.account_id,
             "referenceCode": transaction.external_id,
             "description": billing_document.description,
             "language": "es",
             "signature": self.signature( transaction.external_id, transaction.value,billing_document.currency),
             "notifyUrl": confirmation_url,
             "additionalValues": {
                "TX_VALUE": {
                   "value": transaction.value.to_f,
                   "currency": billing_document.currency
             },
                "TX_TAX": {
                   "value": transaction.tax.to_f,
                   "currency": billing_document.currency
             },
                "TX_TAX_RETURN_BASE": {
                   "value": transaction.base.to_f,
                   "currency": billing_document.currency
             }
             },
             "buyer": {
                "emailAddress": I18n.transliterate(payment_info.payer_email.to_s)
             }
          },
          "payer": {
             "fullName": @demo_name.nil? ? I18n.transliterate(payment_info.payer_full_name.to_s) : @demo_name,
             "emailAddress": I18n.transliterate(payment_info.payer_email.to_s),
             "contactPhone": I18n.transliterate(payment_info.payer_phone.to_s)
          },
          "extraParameters": {
             "RESPONSE_URL": response_url,
             "PSE_REFERENCE1": payment_info.ip_address,
             "FINANCIAL_INSTITUTION_CODE": I18n.transliterate(payment_info.financial_institution.to_s),
             "USER_TYPE": I18n.transliterate(payment_info.user_type.to_s),
             "PSE_REFERENCE2": I18n.transliterate(payment_info.payer_dni_type.to_s),
             "PSE_REFERENCE3": I18n.transliterate(payment_info.payer_dni_number.to_s)
          },
          "type": "AUTHORIZATION_AND_CAPTURE",
          "paymentMethod": "PSE",
          "paymentCountry": "CO",
          "ipAddress": payment_info.ip_address,
          "cookie": payment_info.device_session_id,
          "userAgent": payment_info.user_agent
       },
       "test": false
    }
    response = self.get_payu_response(target_params,transaction)
  end


  def redcompra_request transaction,billing_document,confirmation_url,payment_info
    user = billing_document.user
    target_params = {
       "language": "es",
       "command": "SUBMIT_TRANSACTION",
       "merchant": {
          "apiKey": self.api_key,
          "apiLogin": self.api_login
       },
       "transaction": {
          "order": {
             "accountId": self.account_id,
             "referenceCode": transaction.external_id,
             "description": billing_document.description,
             "language": "es",
             "signature": self.signature( transaction.external_id, transaction.value,billing_document.currency),
             "notifyUrl": confirmation_url,
             "additionalValues": {
                "TX_VALUE": {
                   "value": transaction.value.to_f,
                   "currency": "CLP"
                }
             },
             "buyer": {
                "merchantBuyerId": user.id,
                "fullName": user.name,
                "emailAddress": user.email,
                "contactPhone": user.contact_phone,
                "dniNumber": user.identification_number,
                "shippingAddress": {
                   "street1": user.location.address1,
                   "street2": user.location.address2,
                   "city": user.location.city_name,
                   "state": user.location.state_name,
                   "country": "CL",
                   "postalCode": user.location.zip_code,
                   "phone": user.contact_phone
                }
             }
          },
          "payer": {
             "merchantPayerId": user.id,
             "fullName": user.name,
             "emailAddress": user.email,
             "contactPhone": user.contact_phone,
             "dniNumber": user.identification_number,
             "billingAddress": {
                 "street1": user.location.address1,
                 "street2": user.location.address2,
                 "city": user.location.city_name,
                 "state": user.location.state_name,
                 "country": "CL",
                 "postalCode": user.location.zip_code,
                 "phone": user.contact_phone
             }
          },
          "extraParameters": {
             "RESPONSE_URL": response_url
          },


          "type": "AUTHORIZATION_AND_CAPTURE",
          "paymentMethod": "TRANSBANK_DEBIT",
          "paymentCountry": "CL",
          "deviceSessionId": Digest::MD5.hexdigest("#{payment_info.device_session_id}#{(Time.zone.now.to_f*1000).to_i.to_s}"),
          "ipAddress": payment_info.ip_address,
          "cookie": payment_info.device_session_id,
          "userAgent": payment_info.user_agent
       },
       "test": false
    }

  end

  def spei_request transaction,billing_document,confirmation_url,payment_info
    target_params = {
       "language": "es",
       "command": "SUBMIT_TRANSACTION",
       "merchant": {
          "apiKey": self.api_key,
          "apiLogin": self.api_login
       },
       "transaction": {
          "order": {
             "accountId": self.account_id,
             "referenceCode": transaction.external_id,
             "description": billing_document.description,
             "language": "es",
             "signature": self.signature( transaction.external_id, transaction.value,billing_document.currency),
             "notifyUrl": confirmation_url,
             "additionalValues": {
                "TX_VALUE": {
                   "value": transaction.value.to_f,
                   "currency": billing_document.currency
                },
                "TX_TAX": {
                   "value": transaction.tax.to_f,
                   "currency": billing_document.currency
                },
                "TX_TAX_RETURN_BASE": {
                   "value": transaction.base.to_f,
                   "currency": billing_document.currency
                }
             },
             "buyer": {
                "fullName": I18n.transliterate(payment_info.payer_full_name.to_s),
                "emailAddress": billing_document.isa.user.email
             }
          },
          "type": "AUTHORIZATION_AND_CAPTURE",
          "paymentMethod": "SPEI",
          "expirationDate": Time.now.to_date + 15.days,
          "paymentCountry": "MX",
          "ipAddress": payment_info.user_agent
       },
       "test": false
    }

    response = self.get_payu_response(target_params,transaction)

  end


end
