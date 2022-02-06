class GenerateTeamSupervisorRelationshipsInteractor < ApplicationInteractor

  def call
    return unless context.batch.instance_of? TeamSupervisorBatch
    return unless context.batch.relationships_file

    perform
  end

  def perform
    invalid_file_fail unless context.batch.valid_file?
    
    ActiveRecord::Base.transaction do
      context.records = context.batch.get_records
      context.records.each do |record|
        student = Student.find_by(id: record['student_id'])
        if student.instance_of? Student
          supervisor = User.find_by(email: record['support_email'])
          if supervisor.instance_of? User

            support_role_id = get_support_role_id(record)
            reset_team_supervisor(record, support_role_id, student)

            team_supervisor = TeamSupervisor.create({team_member_id: student.id, supervisor_id: supervisor.id, support_role_id: support_role_id})
            
            if team_supervisor.errors.any?
              team_supervisor_fail(team_supervisor.errors.messages[:support_role])
            else
              context.batch.save
            end
          else
            invalid_supervisor_fail(record['support_email'])
          end
        else
          invalid_student_fail(record['student_id'])
        end
      end
    end
  end

  private
  
  def get_support_role_id(record)
    TeamSupervisorBatch.translate_supervisor_role(record['support_type'])
  end

  def reset_team_supervisor(record, support_role_id, student)
    support_role_doesnot_exist_fail(record) if support_role_id.nil?

    if support_role_id == 2 || support_role_id == 3 # academic or work
      destroy_team_supervisors(student.id, [2, 3]) # delete where support_role is work and academic
    elsif support_role_id == 5 # collection
      destroy_team_supervisors(student.id, 5) # delete where support_role is collection
    end
  end

  def destroy_team_supervisors(team_member_id, support_role_ids)
    TeamSupervisor.where(team_member_id: team_member_id, support_role_id: support_role_ids).destroy_all
  end

  def invalid_file_fail
    context.fail!(message: I18n.t('team_supervisor_batch.flash.create.invalid_file'))
  end

  def team_supervisor_fail(message)
    context.fail!(message: message)
    execute_rollback
  end

  def support_role_doesnot_exist_fail(record)
    context.fail!(message: I18n.t('team_supervisor_batch.flash.create.support_role_doesnot_exist', support_role: record['support_type']))
    execute_rollback
  end

  def invalid_student_fail(student_id)
    context.fail!(message: I18n.t('team_supervisor_batch.flash.create.invalid_student', student_id: student_id))
    execute_rollback
  end

  def invalid_supervisor_fail(supervisor_email)
    context.fail!(message: I18n.t('team_supervisor_batch.flash.create.invalid_supervisor', supervisor_email: supervisor_email))
    execute_rollback
  end

  def execute_rollback
    raise ActiveRecord::Rollback
  end
end