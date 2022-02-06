class Gateway
  attr_accessor :country, :pasarela, :pasarela_pagos_recurrentes_mastercard, :pasarela_pagos_recurrentes_visa

  TIMEOUT_FOR_GATEWAY = 25

  def initialize( fondo )
    @fondo = fondo

    @country = fondo.lumni_poblacion.lmn_codigopais__c
    #TODO ELIMINAR
    #@country = 'CL'

    @pasarela = @fondo.pasarela_activa
    #TODO ELIMINAR
    #@pasarela = LumniPasarela.find_by_lmn_pais__c('CL')
  end


  def process_credit_card_payment( language, currency, reference_code, description, notify_url, base, tax, value, buyer_id, buyer_full_name,
                                   buyer_email, buyer_contact_phone, payer_full_name, payer_email, payer_contact_phone,
                                   payment_method, card_name, card_number, security_code, expiration_year, expiration_month,
                                   devise_session_id, ip_address, cookie, user_agent, buyer_dni_number, payer_dni_number,
                                   installments_number)
    merchantId = @pasarela.active_merchant_id
    data_for_signature = "#{@pasarela.api_login}~#{merchantId}~#{reference_code}~#{value}~#{currency}"
    signature = Digest::MD5.hexdigest(data_for_signature)
    params = {
        'language': "#{language}",
        'command': "SUBMIT_TRANSACTION",
        'merchant': {
            'apiKey': "#{@pasarela.api_login}",
            'apiLogin': "#{@pasarela.api_key}"
        },
        'transaction': {
            'order': {
                'accountId': "#{@pasarela.active_account_id}",
                'referenceCode': "#{reference_code}",
                'description': "#{description}",
                'language': "#{language}",
                'signature': "#{signature}",
                'notifyUrl': "#{notify_url}",
                'additionalValues': {
                    'TX_VALUE': {
                        'value': value,
                        'currency': "#{currency}"
                    },
                    'TX_TAX': {
                        'value': tax,
                        'currency': "#{currency}"
                    },
                    'TX_TAX_RETURN_BASE': {
                        'value': base,
                        'currency': "#{currency}"
                    }
                },
                'buyer': {
                    'merchantBuyerId': "#{buyer_id}",
                    'fullName': "#{buyer_full_name}",
                    'emailAddress': "#{buyer_email}",
                    'contactPhone': "#{buyer_contact_phone}",
                    'dniNumber': "#{buyer_dni_number}"
                }
            },
            'payer': {
                'fullName': "#{payer_full_name}",
                'emailAddress': "#{payer_email}",
                'contactPhone': "#{payer_contact_phone}",
                'dniNumber': "#{payer_dni_number}"
            },
            'creditCard': {
                'number': "#{card_number}",
                'securityCode': "#{security_code}",
                'expirationDate': "#{expiration_year}/#{expiration_month}",
                'name': "#{card_name}"
            },
            'extraParameters': {
                'INSTALLMENTS_NUMBER': installments_number
            },
            'type': "AUTHORIZATION_AND_CAPTURE",
            'paymentMethod': "#{payment_method}",
            'paymentCountry': "#{@country}",
            'deviceSessionId': "#{devise_session_id}",
            'ipAddress': "#{ip_address}",
            'cookie': "#{cookie}",
            'userAgent': "#{user_agent}"
        },
        'test': @pasarela.use_production_gateway? ? false : true
    }

    @response = RestClient::Request.execute(method: :post, url: @pasarela.active_url_for_gateway_payments,
                                            :payload => params.to_json, timeout: TIMEOUT_FOR_GATEWAY,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => @pasarela.use_production_gateway? ? true : false )
    @response.force_encoding('UTF-8')
    Rails.logger.info(GlobalConstants.get_prefix_for_logs+"Mensaje de respuesta credit card = #{@response.body}")
    @response
  end

  def process_debit_card_payment( language, currency, reference_code, description, notify_url, base, tax, value, buyer_email,
                                  payer_full_name, payer_email, payer_contact_phone, ip_address, cookie, user_agent, test,
                                  response_url, pse_reference1, pse_reference2, pse_reference3, finantial_institution_code,
                                  user_type )
    merchantId = @pasarela.active_merchant_id
    data_for_signature = "#{@pasarela.api_login}~#{merchantId}~#{reference_code}~#{value}~#{currency}"
    signature = Digest::MD5.hexdigest(data_for_signature)

    params = {
        'language': "#{language}",
        'command': "SUBMIT_TRANSACTION",
        'merchant': {
            'apiKey': "#{@pasarela.api_login}",
            'apiLogin': "#{@pasarela.api_key}"
        },
        'transaction': {
            'order': {
                'accountId': "#{@pasarela.active_account_id}",
                'referenceCode': "#{reference_code}",
                'description': "#{description}",
                'language': "es",
                'signature': "#{signature}",
                'notifyUrl': "#{notify_url}",
                'additionalValues': {
                    'TX_VALUE': {
                        'value': value,
                        'currency': "#{currency}"
                    },
                    'TX_TAX': {
                        'value': tax,
                        'currency': "#{currency}"
                    },
                    'TX_TAX_RETURN_BASE': {
                        'value': base,
                        'currency': "#{currency}"
                    }
                },
                'buyer': {
                    'emailAddress': "#{buyer_email}"
                }
            },
            'payer': {
                'fullName': "#{payer_full_name}",
                'emailAddress': "#{payer_email}",
                'contactPhone': "#{payer_contact_phone}"
            },
            'extraParameters': {
                'RESPONSE_URL': "#{response_url}",
                'PSE_REFERENCE1': "#{pse_reference1}",
                'FINANCIAL_INSTITUTION_CODE': "#{finantial_institution_code}",
                'USER_TYPE': "#{user_type}",
                'PSE_REFERENCE2': "#{pse_reference2}",
                'PSE_REFERENCE3': "#{pse_reference3}"
            },
            'type': "AUTHORIZATION_AND_CAPTURE",
            'paymentMethod': "PSE",
            'paymentCountry': "CO",
            'ipAddress': "#{ip_address}",
            'cookie': "#{cookie}",
            'userAgent': "#{user_agent}"
        },
        'test': test
    }

    @response = RestClient::Request.execute(method: :post, url: @pasarela.active_url_for_gateway_payments,
                                            :payload => params.to_json, timeout: TIMEOUT_FOR_GATEWAY,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => @pasarela.use_production_gateway? ? true : false )
    @response.force_encoding('UTF-8')
    Rails.logger.info(GlobalConstants.get_prefix_for_logs+"Mensaje de respuesta debit card = #{@response.body}")
    @response
  end


  def process_bank_payment(language, currency, reference_code, description, notify_url, value, test,
                           buyer_id, buyer_full_name, buyer_email, buyer_contact_phone, ip_address,
                           cookie, user_agent)
    merchantId = @pasarela.active_merchant_id
    data_for_signature = "#{@pasarela.api_login}~#{merchantId}~#{reference_code}~#{value}~#{currency}"
    signature = Digest::MD5.hexdigest(data_for_signature)

    params = {
        "language": "#{language}",
        "command": "SUBMIT_TRANSACTION",
        "merchant": {
            "apiKey": "#{@pasarela.api_login}",
            "apiLogin": "#{@pasarela.api_key}"
        },
        "transaction": {
            "order": {
                "accountId": "#{@pasarela.active_account_id}",
                "referenceCode": "#{reference_code}",
                "description": "#{description}",
                "language": "#{language}",
                "signature": "#{signature}",
                "notifyUrl": "#{notify_url}",
                "additionalValues": {
                    "TX_VALUE": {
                        "value": value,
                        "currency": "#{currency}"
                    }
                },
                "buyer": {
                    "merchantBuyerId": "#{buyer_id}",
                    "fullName": "#{buyer_full_name}",
                    "emailAddress": "#{buyer_email}",
                    "contactPhone": "#{buyer_contact_phone}"
                }
            },

            "type": "AUTHORIZATION_AND_CAPTURE",
            "paymentMethod": "BANK_REFERENCED",
            "paymentCountry": "CO",
            "ipAddress": "#{ip_address}",
            "cookie": "#{cookie}",
            "userAgent": "#{user_agent}"
        },
        "test": test
    }
    #Rails.logger.info(GlobalConstants.get_prefix_for_logs+"Parámetros enviados pago banco = #{params.to_json.to_s}")
    @response = RestClient::Request.execute(method: :post, url: @pasarela.active_url_for_gateway_payments,
                                            :payload => params.to_json, timeout: TIMEOUT_FOR_GATEWAY,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => @pasarela.use_production_gateway? ? true : false )
    @response.force_encoding('UTF-8')
    Rails.logger.info(GlobalConstants.get_prefix_for_logs+"Mensaje de respuesta pago banco = #{@response.body}")
    @response
  end

  def calculate_sign_for_response(merchant_id, reference_code, value, currency, transaction_state)
    string_for_new_sign = "#{@pasarela.api_login}~#{merchant_id}~#{reference_code}~#{BigDecimal.new(value, 0).round(1, :half_even).to_s}~#{currency}~#{transaction_state}"
    calculated_sign = Digest::MD5.hexdigest(string_for_new_sign)
    Rails.logger.info(GlobalConstants.get_prefix_for_logs+"String for new sign: #{string_for_new_sign.to_s}")
    Rails.logger.info(GlobalConstants.get_prefix_for_logs+"Calculated_sign: #{calculated_sign.to_s}")
    calculated_sign
  end

  def calculate_sign_for_confirmation(merchant_id, reference_code, value, currency, transaction_state)
    string_for_new_sign = "#{@pasarela.api_login}~#{merchant_id}~#{reference_code}~#{value.to_f.round(2).to_s}~#{currency}~#{transaction_state}"
    calculated_sign = Digest::MD5.hexdigest(string_for_new_sign)
    Rails.logger.info(GlobalConstants.get_prefix_for_logs+"Calculated_sign: #{calculated_sign.to_s}")
    calculated_sign
  end

  def get_currency
    case @country
      when 'CO'
        'COP'
      when 'MX'
        'MXN'
      when 'CL'
        'CLP'
      when 'PE'
        'PEN'
      else
        'N/A'
    end
  end

  def self.get_transaction_state_message_for_response(transaction_state)
    case transaction_state
      when 4
        'Transacción aprobada.'
      when 5
        'Transacción expirada.'
      when 6
        'Transacción fallida o rechazada.'
      when 7
        'Transacción pendiente'
      when 12
        'Transacción pendiente, por favor revisar si el débito fue realizado en el banco.'
      when 104
        'Error.'
      else
        'Otro.'
    end
  end

  def self.get_transaction_state_message_for_confirmation(transaction_state)
    case transaction_state
      when 4
        'Transacción aprobada.'
      when 5
        'Transacción expirada.'
      when 6
        'Transacción declinada.'
      else
        'Otro.'
    end
  end

  def self.obtener_nombre_medio_pago(payment_method_id)
    case payment_method_id
      when 2
        'Tarjeta crédito'
      when 4
        'PSE - Transferencias bancarias'
      when 5
        'Débitos ACH'
      when 6
        'Tarjeta débito'
      when 7
        'Efectivo'
      when 8
        'Pago referenciado'
      when 10
        'Pago en bancos'
      else
        'Otro'
    end
  end

  #BEGIN Para pagos recurrentes con PayU para Colombia y Perú

  def get_credit_cards_supported_for_recurring_payments
    case @country
      when 'CO'
        franchises = { 'Visa' => 'VISA', 'Mastercard' => 'MASTERCARD' }
        franchises
      when 'PE'
        franchises = { 'Visa' => 'VISA', 'Mastercard' => 'MASTERCARD' }
        franchises
      when 'MX'
        franchises = { 'Visa' => 'VISA', 'Mastercard' => 'MASTERCARD' }
        franchises
    end
  end

  #Para registrar una tarjeta de crédito utilizando la API de PayU
  def register_credit_card( language, buyer_id, payment_method, card_name, card_number, expiration_year,
                            expiration_month, payer_dni_number)
    params = {
        'language': "#{language}",
        'command': "CREATE_TOKEN",
        'merchant': {
            'apiKey': "#{@pasarela.api_login}",
            'apiLogin': "#{@pasarela.api_key}"
        },
        'creditCardToken': {
            'payerId': "#{buyer_id}",
            'name': "#{card_name}",
            'identificationNumber': "#{payer_dni_number}",
            'paymentMethod': "#{payment_method}",
            'number': "#{card_number}",
            'expirationDate': "#{expiration_year}/#{expiration_month}"
        },
        'test': @pasarela.use_production_gateway? ? false : true
    }
    @response = RestClient::Request.execute(method: :post, url: @pasarela.active_url_for_gateway_payments,
                                            :payload => params.to_json, timeout: TIMEOUT_FOR_GATEWAY,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => @pasarela.use_production_gateway? ? true : false )
    @response.force_encoding('UTF-8')
    Rails.logger.info(GlobalConstants.get_prefix_for_logs+"Mensaje de respuesta registro medio pago tarjeta = #{@response.body}")
    @response
  end

  #Para reembolsar una transacción con tarjeta de crédito
  def process_refund_credit_card_payment( language, order_id, parent_transaction_id )
    params = {
        'language': "#{language}",
        'command': "SUBMIT_TRANSACTION",
        'merchant': {
            'apiKey': "#{@pasarela.api_login}",
            'apiLogin': "#{@pasarela.api_key}"
        },
        'transaction': {
            'order': {
                'id': order_id
            },
            'type': "REFUND",
            'reason': "Fue un pago de prueba creado durante el registro de una tarjeta para pagos tokenizados",
            'parentTransactionId': "#{parent_transaction_id}"
        },
        'test': @pasarela.use_production_gateway? ? false : true
    }

    @response = RestClient::Request.execute(method: :post, url: @pasarela.active_url_for_gateway_payments,
                                            :payload => params.to_json, timeout: TIMEOUT_FOR_GATEWAY,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => @pasarela.use_production_gateway? ? true : false )
    @response.force_encoding('UTF-8')
    Rails.logger.info(GlobalConstants.get_prefix_for_logs+"Mensaje de respuesta reembolso pago tarjeta de crédito = #{@response.body}")
    @response
  end

  #Para eliminar una tarjeta de crédito utilizando la API de PayU
  def remove_credit_card( language, buyer_id, credit_card_token_id )
    params = {
        'language': "#{language}",
        'command': "REMOVE_TOKEN",
        'merchant': {
            'apiKey': "#{@pasarela.api_login}",
            'apiLogin': "#{@pasarela.api_key}"
        },
        'removeCreditCardToken': {
            'payerId': "#{buyer_id}",
            'creditCardTokenId': "#{credit_card_token_id}"
        },
        'test': @pasarela.use_production_gateway? ? false : true
    }

    @response = RestClient::Request.execute(method: :post, url: @pasarela.active_url_for_gateway_payments,
                                            :payload => params.to_json, timeout: TIMEOUT_FOR_GATEWAY,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => @pasarela.use_production_gateway? ? true : false )
    @response.force_encoding('UTF-8')
    Rails.logger.info(GlobalConstants.get_prefix_for_logs+"Mensaje de respuesta eliminación medio pago tarjeta = #{@response.body}")
    @response
  end

  #Definición del valor por defecto a debitar de la tarjeta al momento de guardarla en PayU
  def get_value_to_debit_during_card_registration
    case @country
      when 'CO'
        10000
      when 'PE'
        10
      when 'MX'
        55
    end
  end

  #Para registrar un pago de prueba, registrar la tarjeta y devolver el pago de prueba
  def complete_credit_card_registration( tarjeta_id, language, currency, description, notify_url, buyer_id, buyer_full_name,
                                   buyer_email, buyer_contact_phone, payer_full_name, payer_email, payer_contact_phone,
                                   payment_method, card_name, card_number, security_code, expiration_year, expiration_month,
                                   devise_session_id, ip_address, cookie, user_agent, buyer_dni_number, payer_dni_number,
                                   installments_number)
    @tarjeta = Tarjeta.find(tarjeta_id)
    @tarjeta.estado = Tarjeta::VERIFICACION_FALLIDA
    error_message = ''
    verificacion_codigo_referencia = @tarjeta.verificacion_codigo_referencia
    @tarjeta.verificacion_valor_debitado = get_value_to_debit_during_card_registration
    response_registro_pago_prueba = process_credit_card_payment(language, currency, verificacion_codigo_referencia,
                                                                description, notify_url, 0, 0, get_value_to_debit_during_card_registration, buyer_id, buyer_full_name,
                                                                buyer_email, buyer_contact_phone, payer_full_name, payer_email, payer_contact_phone,
                                                                payment_method, card_name, card_number, security_code, expiration_year, expiration_month,
                                                                devise_session_id, ip_address, cookie, user_agent, buyer_dni_number, payer_dni_number,
                                                                installments_number)

    json_body_registro_pago_prueba = JSON.parse(response_registro_pago_prueba.body)
    @tarjeta.verificacion_resultado_pasarela = json_body_registro_pago_prueba.to_s
    #Se verifica si el registro del pago de prueba fue exitoso
    if json_body_registro_pago_prueba['code'] == 'SUCCESS' && json_body_registro_pago_prueba['transactionResponse']['responseCode'] == 'APPROVED'
      @tarjeta.verificacion_exitosa = true
      @tarjeta.verificacion_order_id = json_body_registro_pago_prueba['transactionResponse']['orderId']
      @tarjeta.verificacion_transaction_id = json_body_registro_pago_prueba['transactionResponse']['transactionId']
      @tarjeta.verificacion_fecha_ejecucion = Time.zone.now
      response_registro_tarjeta = register_credit_card( language, buyer_id, payment_method, card_name, card_number,
                                                        expiration_year, expiration_month, payer_dni_number)

      json_body_registro_tarjeta = JSON.parse(response_registro_tarjeta.body)
      @tarjeta.registro_medio_resultado_pasarela = json_body_registro_tarjeta.to_s
      #Se verifica si el registro de la tarjeta fue exitoso
      if json_body_registro_tarjeta['code'] == 'SUCCESS' && json_body_registro_tarjeta['creditCardToken']['creditCardTokenId'].present?
        @tarjeta.registro_medio_exitoso = true
        @tarjeta.token_medio_pago = json_body_registro_tarjeta['creditCardToken']['creditCardTokenId']
        @tarjeta.estado = Tarjeta::ACTIVO
      else
        error_message += "Hubo un error al registrar la tarjeta: #{json_body_registro_tarjeta['error']} "
        if json_body_registro_tarjeta['creditCardToken'].present?
          error_message += " #{json_body_registro_tarjeta['creditCardToken']['errorDescription']}"
        end
      end
    else
      error_message += "Hubo un error al registrar el pago de prueba: #{json_body_registro_pago_prueba['error']} "
      if json_body_registro_pago_prueba['transactionResponse'].present?
        error_message += "#{json_body_registro_pago_prueba['transactionResponse']['responseCode']} "
        error_message += "#{json_body_registro_pago_prueba['transactionResponse']['responseMessage']} "
        error_message += "#{json_body_registro_pago_prueba['transactionResponse']['paymentNetworkResponseErrorMessage']}"
      end
    end

    if error_message.present?
      @tarjeta.verificacion_error_general = error_message
      raise error_message
    end
    @tarjeta
  ensure
    @tarjeta.save
    @tarjeta
  end

  #Para registrar la eliminación de una tarjeta de crédito utilizando la API de PayU
  def complete_credit_card_deletion( language, tarjeta_id )

    @tarjeta = Tarjeta.find(tarjeta_id)
    error_message = ''

    @tarjeta.eliminacion_fecha = Time.zone.now
    response_eliminacion_tarjeta = remove_credit_card( language, @tarjeta.user.sfid, @tarjeta.token_medio_pago )
    json_body_eliminacion_tarjeta = JSON.parse(response_eliminacion_tarjeta.body)
    @tarjeta.eliminacion_resultado_pasarela = json_body_eliminacion_tarjeta.to_s
    @tarjeta.estado = Tarjeta::ELIMINADO
    #Se verifica si el registro de la tarjeta fue exitoso
    if (json_body_eliminacion_tarjeta['code'] == 'SUCCESS' && json_body_eliminacion_tarjeta['creditCardToken']['creditCardTokenId'].present?) || (json_body_eliminacion_tarjeta['code'] == 'ERROR' && json_body_eliminacion_tarjeta['transactionResponse'].nil? )
      @tarjeta.eliminacion_exitosa = true
    else
      error_message += "Hubo un error al eliminar la tarjeta: #{json_body_eliminacion_tarjeta['error']}"
      if json_body_eliminacion_tarjeta['creditCardToken'].present?
        error_message += "#{json_body_eliminacion_tarjeta['creditCardToken']['errorDescription']}"
      end
    end

    if error_message.present?
      @tarjeta.eliminacion_error_general = error_message
      raise error_message
    end
    @tarjeta
  ensure
    @tarjeta.save
    @tarjeta
  end

  # Para procesar un pago con token utilizando la API de PayU
  def process_credit_card_payment_with_token( language, currency, reference_code, description, notify_url, value, buyer_id, buyer_full_name,
                                   buyer_email, buyer_contact_phone, payer_full_name, payer_email, payer_contact_phone,
                                   payment_method, card_token, devise_session_id, ip_address, cookie, user_agent, buyer_dni_number,
                                   payer_dni_number, installments_number)
    merchantId = @pasarela.active_merchant_id
    data_for_signature = "#{@pasarela.api_login}~#{merchantId}~#{reference_code}~#{value}~#{currency}"
    signature = Digest::MD5.hexdigest(data_for_signature)
    params = {
        'language': "#{language}",
        'command': "SUBMIT_TRANSACTION",
        'merchant': {
            'apiKey': "#{@pasarela.api_login}",
            'apiLogin': "#{@pasarela.api_key}"
        },
        'transaction': {
            'order': {
                'accountId': "#{@pasarela.active_account_id}",
                'referenceCode': "#{reference_code}",
                'description': "#{description}",
                'language': "#{language}",
                'signature': "#{signature}",
                'notifyUrl': "#{notify_url}",
                'additionalValues': {
                    'TX_VALUE': {
                        'value': value,
                        'currency': "#{currency}"
                    }
                },
                'buyer': {
                    'merchantBuyerId': "#{buyer_id}",
                    'fullName': "#{buyer_full_name}",
                    'emailAddress': "#{buyer_email}",
                    'contactPhone': "#{buyer_contact_phone}",
                    'dniNumber': "#{buyer_dni_number}"
                }
            },
            'payer': {
                'fullName': "#{payer_full_name}",
                'emailAddress': "#{payer_email}",
                'contactPhone': "#{payer_contact_phone}",
                'dniNumber': "#{payer_dni_number}"
            },
            'creditCardTokenId': "#{card_token}",
            'extraParameters': {
                'INSTALLMENTS_NUMBER': installments_number
            },
            'type': "AUTHORIZATION_AND_CAPTURE",
            'paymentMethod': "#{payment_method}",
            'paymentCountry': "#{@country}",
            'deviceSessionId': "#{devise_session_id}",
            'ipAddress': "#{ip_address}",
            'cookie': "#{cookie}",
            'userAgent': "#{user_agent}"
        },
        'test': @pasarela.use_production_gateway? ? false : true
    }

    @response = RestClient::Request.execute(method: :post, url: @pasarela.active_url_for_gateway_payments,
                                            :payload => params.to_json, timeout: TIMEOUT_FOR_GATEWAY,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => @pasarela.use_production_gateway? ? true : false )
    @response.force_encoding('UTF-8')
    Rails.logger.info(GlobalConstants.get_prefix_for_logs+"Mensaje de pago con token credit card = #{@response.body}")
    @response
  end

  #Para consulta un listado de tokens utilizando la API de PayU
  def query_token( language, buyer_id, credit_card_token_id)
    params = {
        'language': "#{language}",
        'command': "GET_TOKENS",
        'merchant': {
            'apiKey': "#{@pasarela_pagos_recurrentes_mastercard.api_login}",
            'apiLogin': "#{@pasarela_pagos_recurrentes_mastercard.api_key}"
        },
        'creditCardTokenInformation': {
            'payerId': "#{buyer_id}",
            'creditCardTokenId': "#{credit_card_token_id}",
            'startDate': "2010-01-01T12:00:00",
            'endDate': "2050-01-01T12:00:00"
        },
        'test': @pasarela_pagos_recurrentes_mastercard.use_production_gateway? ? false : true
    }

    @response = RestClient::Request.execute(method: :post, url: @pasarela_pagos_recurrentes_mastercard.active_url_for_gateway_payments,
                                            :payload => params.to_json, timeout: TIMEOUT_FOR_GATEWAY,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => @pasarela_pagos_recurrentes_mastercard.use_production_gateway? ? true : false )
    @response.force_encoding('UTF-8')
    Rails.logger.info(GlobalConstants.get_prefix_for_logs+"Mensaje de respuesta consulta de toke(s) = #{@response.body}")
    @response
  end

  #END Para pagos recurrentes con PayU para Colombia y Perú

end
