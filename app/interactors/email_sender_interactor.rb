class EmailSenderInteractor < ApplicationInteractor

  def call
    return unless context.batch.instance_of? StudentEmailBatch
    return unless context.batch.email_list.attached?

    perform
  end

  def perform
    invalid_file_fail unless context.batch.valid_file?
    
    ActiveRecord::Base.transaction do
      context.records = context.batch.get_records
      context.records.each do |record|
        student = Student.find_by(id: record['user_id'])
        if student.instance_of? Student
          if is_email_valid?(student.email)
            email_case = context.batch.email_case
            SendEmailsDynamicallyAsync.perform_async(student.id, email_case)
            case email_case
              when 'continuity_postulation_black_rock'
                PerformServiceAsync.perform_async('EmergencyLivingExpensesService', student.email)
              when 'mentory_and_empleability'
                PerformServiceAsync.perform_async('MentoryEmpleabilityService', student.id)
              when 'mentory_acceptance'
                PerformServiceAsync.perform_async('MentoryAcceptanceService', student.id)
              when 'empleability_acceptance'
                PerformServiceAsync.perform_async('EmpleabilityAcceptanceService', student.id)
              when 'mentory__and_empleability_acceptance'
                PerformServiceAsync.perform_async('MentoryEmpleabilityAcceptanceService', student.id)
            end
          else
            invalid_email_fail(record['user_id'])
          end
        else
          invalid_student_fail(record['user_id'])
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
    context.fail!(message: I18n.t('student_email_batch.flash.create.invalid_file'))
  end

  def invalid_student_fail(user_id)
    context.fail!(message: I18n.t('student_email_batch.flash.create.invalid_student', user_id: user_id))
    execute_rollback
  end

  def invalid_email_fail(user_id)
    context.fail!(message: I18n.t('student_email_batch.flash.create.invalid_email', user_id: user_id))
    execute_rollback
  end

  def execute_rollback
    raise ActiveRecord::Rollback
  end
end