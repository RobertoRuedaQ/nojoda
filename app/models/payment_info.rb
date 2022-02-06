class PaymentInfo
  include ActiveModel::Model

  attr_accessor :id, :payment_method, :card_name, :card_number, :security_code, :expiration_month,
                :expiration_year, :base, :tax, :value, :order_id, :device_session_id, :device_session_id_with_user_id,
                :payer_full_name, :payer_email, :payer_dni_type, :payer_dni_number, :payer_phone, :installments_number, :recurring_payment, :accepts_terms_and_conditions,
                :billing_document_id, :payer_address1, :payer_address2,:payer_city,:payer_state,:payer_country,:payer_postal_code,:ip_address,:user_agent,
                :financial_institution,:user_type, :birthday



  def build_from_params params
    params[:paymentinfo].keys.each do |key|
      eval("self.#{key} = params[:paymentinfo][:#{key}]")
    end
  end

  def set_dummy_values
    self.payment_method = 'VISA'
    self.card_name = 'APPROVED' # 'REJECTED' #
    self.card_number = 4097440000000004
    self.security_code = '321'
    self.expiration_year = '2018'
    self.expiration_month = '12'
  end

  def set_default_payer_info(current_user = nil)
    if current_user.present?
      self.payer_full_name = current_user.name
      self.payer_email = current_user.email
      self.payer_dni_number = current_user.personal_information.identification_number
      self.payer_phone = current_user.contact_info.mobile
    end
  end

  def read_attribute(field)
    {
     'payment_method' => @payment_method,
     'card_name' => @card_name,
     'card_number' => @card_number,
     'security_code' => @security_code,
     'expiration_month' => @expiration_month,
     'expiration_year' =>  @expiration_year,
     'base' => @base,
     'tax' => @tax,
     'value' => @value,
     'order_id' => @order_id,
     'device_session_id' => @device_session_id,
     'device_session_id_with_user_id' => @device_session_id_with_user_id,
     'payer_full_name' => @payer_full_name,
     'payer_email' => @payer_email,
     'payer_dni_number' => @payer_dni_number,
     'payer_phone' => @payer_phone,
     'installments_numbe' =>  @installments_number,
     'recurring_payment' =>  @recurring_payment,
     'accepts_terms_and_conditions' =>  @accepts_terms_and_conditions
    }[field]
  end

end