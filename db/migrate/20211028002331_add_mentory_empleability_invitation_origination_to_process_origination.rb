class AddMentoryEmpleabilityInvitationOriginationToProcessOrigination < ActiveRecord::Migration[5.2]
  def change
    add_column :process_originations, :mentory_empleability_invitation_origination_id, :integer
  end
end
