class AuditedAsync
	include Sidekiq::Worker

	sidekiq_options queue: 'default'

  def perform(audit_attributes)
    Audited::Audit.new(audit_attributes).orig_save
  end

end