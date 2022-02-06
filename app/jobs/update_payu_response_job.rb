class UpdatePayuResponseJob < ApplicationJob

    def perform(*args)
      time_now = Time.zone.now

      payu_responses = if time_now.hour == 3
        PayuResponse.where(state: 'PENDING')
      else
        PayuResponse.where(state: 'PENDING').where(created_at: 3.days.ago..time_now)
      end

      payu_responses.each do |response|
        ModelClassesAsync.perform_async('PayuResponse', 'update_response', response.id)
      end
    end
  end
  