class UpdateWompiResponseJob < ApplicationJob

  def perform(*args)
    time_now = Time.zone.now

    t = WompiTransaction.includes(:wompi_response)
    
    transactions = if time_now.hour == 3
      t.where(wompi_responses: { id: nil}).or(t.where.not(wompi_responses: { status: 'PENDING'}))
    else
      t.where(wompi_responses: { id: nil}).or(t.where.not(wompi_responses: { status: 'PENDING'})).where(created_at: 2.days.ago..time_now)
    end

    

    transactions.each do |transaction|
      ModelClassesAsync.perform_async('WompiTransaction', 'get_and_update_from_wompi_service', transaction.id)
    end
  end
end
  