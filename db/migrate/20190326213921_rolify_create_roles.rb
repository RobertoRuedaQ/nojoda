class RolifyCreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:team_profiles_roles, :id => false) do |t|
      t.references :team_profile
      t.references :role
    end
    
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:team_profiles_roles, [ :team_profile_id, :role_id ])
  end

end
