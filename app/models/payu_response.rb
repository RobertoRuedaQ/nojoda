class PayuResponse < ApplicationRecord
      
  resourcify
  audited
  belongs_to :payu_transaction, touch: true
  has_many :payu_extra_param, dependent: :destroy
  has_many :payu_additional_info, dependent: :destroy
  has_one :payment, as: :resource , dependent: :destroy


  before_save :set_last_review_date
  after_commit :create_payment


  def billing_document
    self.payu_transaction.billing_document
  end

  def user
    self.payu_transaction.user
  end

  def user_name
    self.user.name
  end

  def user_identification_number
    self.user.identification_number
  end

  def set_last_review_date
    self.last_review_datetime = Time.now
  end

  def fund_name
    self.fund.name
  end

  def value 
    self.payu_transaction.value
  end

  def fund
    self.billing_document.fund
  end



  def create_payment
  if self.state == 'APPROVED' && self.payment.nil?
  
  payment_date = self.created_at ? self.created_at : Time.zone.now.to_date


      Payment.create({billing_document_id: self.payu_transaction.billing_document_id, 
        status: 'active', payment_source: 'electronic_payment', 
        payment_method: self.payu_transaction.payment_method, 
        value: self.payu_transaction.value,
        resource_type: 'PayuResponse',
        resource_id: self.id,
        payment_date: payment_date})
    end
  end

  def target_redirect
    target_record = self.payu_extra_param.find_by_key(['URL_PAYMENT_REDIRECT','URL_PAYMENT_RECEIPT_HTML','BANK_URL','URL_PAYMENT_REDIRECT','URL_BOLETO_BANCARIO'])
    result = target_record.nil? ? nil : target_record.value
    if !self.payu_extra_param.find_by_key('TRANSBANK_DIRECT_TOKEN').nil? && !result.nil?
      result += "?token_ws=#{self.payu_extra_param.find_by_key('TRANSBANK_DIRECT_TOKEN').value}"
    end
    return result
  end

  def gateway
    self.payu_transaction.payu_gateway
  end

  def get_updated_order
    target_params = {
      "test": false,
      "language": "en",
      "command": "ORDER_DETAIL",
      "merchant": {
        "apiLogin": self.gateway.api_login,
        "apiKey": self.gateway.api_key
      },
      "details": {
        "orderId": self.order_id
      }
    }
    response = self.gateway.get_payu_report(target_params)
  end

  def get_updated_response
    target_params = {
        "test": false,
        "language": "en",
        "command": "TRANSACTION_RESPONSE_DETAIL",
        "merchant": {
          "apiLogin": self.gateway.api_login,
          "apiKey": self.gateway.api_key
        },
        "details": {
          "transactionId": self.transaction_id
        }
    }
    response = self.gateway.get_payu_report(target_params)
  end

  def update_response
    if self.code != 'ERROR' && ['PENDING','SUBMITTED'].include?(self.state) && 
      !self.gateway.url.include?('checkout') && !self.gateway.url.include?('sandbox')
      new_response = self.get_updated_response
      result = self.saving_response(self, new_response, self.payu_transaction)
    else
      result = self
    end
    return result
  end


  def self.build_form_response target_response, target_transaction
    new_response = PayuResponse.new
    new_response.saving_response(new_response, target_response, target_transaction)
  end

  def saving_response new_response, target_response, target_transaction
    new_response.code = target_response['code']
    new_response.error = target_response['error']
    new_response.payu_transaction_id = target_transaction.id

      if !target_response['transactionResponse'].nil?
        @response_body = target_response['transactionResponse']
      elsif !target_response['result'].nil? && !target_response['result']['payload'].nil?
        @response_body = target_response['result']['payload']
      end

    if !@response_body.nil?

      transaction_params = @response_body.keys - ['extraParameters','additionalInfo']
      transaction_params.each do |target_param|
        eval("new_response.#{target_param.underscore} = @response_body['#{target_param}']")
      end
      if new_response.save
        if !@response_body['extraParameters'].nil?
          @response_body['extraParameters'].keys.each do |extra_param|
            temp_extra_param = new_response.payu_extra_param.find_by_key(extra_param)
            if temp_extra_param.nil?
              PayuExtraParam.create(payu_response_id: new_response.id, key: extra_param, value: @response_body['extraParameters'][extra_param])
            else
              temp_extra_param.update({value: @response_body['extraParameters'][extra_param]})
            end
          end
        end

        if !@response_body['additionalInfo'].nil?
          @response_body['additionalInfo'].keys.each do |additional_info|
            temp_additional_info = new_response.payu_additional_info.find_by_name(additional_info)
            if temp_additional_info.nil?
              PayuAdditionalInfo.create(payu_response_id: new_response.id, name: additional_info, value: @response_body['additionalInfo'][additional_info])
            else
              temp_additional_info.update({value: @response_body['additionalInfo'][additional_info]})
            end
          end
        end
      end
    else
      new_response.save
    end
    return new_response
  end

end
