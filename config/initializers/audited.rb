module Audited
  class Audit
    alias_method :orig_save, :save

    def save(*_args)
      if User.current.present?
        self.user_type = 'User'
        self.user_id = User.current.id
        self.username = User.current.full_name
      end
      AuditedAsync.perform_async(attributes)
      true
    end
  end
end