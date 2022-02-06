class ManageWompiResponseService
  def self.for(transaction)
    new(transaction).perform
  end

  def initialize(transaction)
    @transaction = transaction
  end

  def perform
    return if @transaction.nil?
    return unless @transaction.instance_of?(WompiTransaction)

    @response = @transaction.wompi_response
    structure = wompi_response_structure
    if structure
      if @response.nil?
        @response = WompiResponse.new(
          wompi_transaction_id: @transaction.id
        )
        @response.attributes = structure
        @response.save
      else
        @response.update(structure)
      end
    end
  end


  private

  def transaction_updated
    @transaction.find_transaction_in_wompi_service
  end

  def wompi_response_structure
    transaction_update = transaction_updated
    return if transaction_update.nil?
    return {
      status: transaction_update['status'],
      merchant_order_id: transaction_update['id'],
      external_id: transaction_update['reference'],
      payment_type: transaction_update['payment_method_type'],
      currency_id: transaction_update['currency'],
      payment_method: transaction_update['payment_method_type'],
      transaction_amount: (transaction_update['amount_in_cents'].to_i /  100),
      status_detail: transaction_update['status_message'],
      payment_id: transaction_update['id'] 
    }
  end
end