class UpdatePayuConfirmationResponseService
  def self.for(payu_confirmation_id)
    new(payu_confirmation_id).perform
  end

  def initialize(payu_confirmation_id)
    @payu_confirmation = PayuConfirmation.find(payu_confirmation_id)
  end

  def perform
    return if @payu_confirmation.nil?

    payu_transaction = @payu_confirmation.payu_transaction
    response = payu_transaction.payu_response
    
    if @payu_confirmation.response_message_pol.present?
      if response.nil?
        response = PayuResponse.create({code: "SUCCESS", transaction_id: @payu_confirmation.payu_transaction.id, 
          state: @payu_confirmation.response_message_pol, response_code: @payu_confirmation.response_code_pol,
          payu_transaction_id: payu_transaction.id})
      else
        response.update(state: @payu_confirmation.response_message_pol)
      end
    end
  end
end