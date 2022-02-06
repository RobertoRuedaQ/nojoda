class GenerateTokensInteractor < ApplicationInteractor
  def call
    return unless context.batch.instance_of? StudentTokenBatch
    return unless context.batch.tokens_list.attached?
    
    perform
  end
  
  def perform
    invalid_file_fail unless context.batch.valid_file?
    
    ActiveRecord::Base.transaction do
      context.records = context.batch.get_records
      context.records.each do |record|
        if is_email_valid?(record[0])
          CreateRecordAsync.perform_async('funding_token', {funding_opportunity_id: context.batch.funding_opportunity_id, token: SecureRandom.alphanumeric(8), token_status: 'active', target_email: record[0], name: record[1]})
        else
          invalid_email_fail(record[0])
        end
      end
    end
  end

  private

  def is_email_valid?(email)
    regex_pattern = Devise.email_regexp
    regex_pattern.match?(email)
  end

  def invalid_file_fail
    context.fail!(message: I18n.t('student_token_batch.flash.create.invalid_file'))
  end

  def invalid_email_fail(invalid_email)
    context.fail!(message: I18n.t('student_token_batch.flash.create.invalid_email', invalid_email: invalid_email))
    execute_rollback
  end

  def execute_rollback
    raise ActiveRecord::Rollback
  end
end