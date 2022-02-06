class ManageMercadoPagoResponseService
  def self.for(mp_transaction, payment_id)
    new(mp_transaction, payment_id).perform
  end

  def initialize(mp_transaction, payment_id)
    @transaction = mp_transaction
    @payment_id = payment_id
  end

  def perform
    return if @payment_id.nil?
    return if @transaction.nil?
    return unless @transaction.instance_of?(MercadoPagoTransaction)

    @response = @transaction.mercado_pago_response
    if @response.nil?
      @response = MercadoPagoResponse.new(
        payment_id:  @payment_id,
        mercado_pago_transaction_id: @transaction.id
      )
      @response.attributes = mercado_pago_response_structure
      @response.save
    else
      @response.update(mercado_pago_response_structure)
    end
  end


  private

  def mercado_pago_response_structure
    updated_response = @response.get_updated_response
    return {
      status: updated_response['status'],
      merchant_order_id: updated_response['order']['id'],
      collection_id: updated_response['collector_id'],
      external_id: updated_response['external_reference'],
      payment_type: updated_response['payment_type_id'],
      processing_mode: updated_response['processing_mode'],
      merchant_account_id: updated_response['merchant_account_id'],
      authorization_code: updated_response['authorization_code'],
      currency_id: updated_response['currency_id'],
      date_approved: updated_response['date_approved'],
      payment_method: updated_response['payment_method_id'],
      transaction_amount: updated_response['transaction_amount'],
      status_detail: updated_response['status_detail']
    }
  end
end