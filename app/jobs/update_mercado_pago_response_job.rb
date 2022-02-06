class UpdateMercadoPagoResponseJob < ApplicationJob

  def perform(*args)
    time_now = Time.zone.now

    responses = if time_now.hour == 3
      MercadoPagoResponse.where(status: ['in_process', 'pending'])
    else
      MercadoPagoResponse.where(status: ['in_process', 'pending']).where(created_at: 2.days.ago..time_now)
    end

    responses.each do |response|
      ModelClassesAsync.perform_async('MercadoPagoResponse', 'update_response', response.id)
    end
  end
end
  