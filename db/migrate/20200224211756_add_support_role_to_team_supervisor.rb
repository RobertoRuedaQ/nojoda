class AddSupportRoleToTeamSupervisor < ActiveRecord::Migration[5.2]
  def change
    add_reference :team_supervisors, :support_role, foreign_key: true
  end
end
