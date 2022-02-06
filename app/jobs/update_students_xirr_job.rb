class UpdateStudentsXirrJob < ApplicationJob
  queue_as :worker
  
  def perform
    Isa.where(stored_general_status: ['active','manual_activation', 'recovered_from_default']).each do |isa|
      PerformServiceAsync.perform_async('UpdateXirrService', isa.id)
    end
  end
end