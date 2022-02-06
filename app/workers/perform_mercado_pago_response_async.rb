class PerformMercadoPagoResponseAsync < ApplicationController
  include Sidekiq::Worker

  sidekiq_options queue: 'heavy_work'
  
  def perform(transaction_id, payment_id)
    mp_transaction = MercadoPagoTransaction.find_by_external_id(transaction_id)
    ManageMercadoPagoResponseService.for(mp_transaction, payment_id)
  end
end
  