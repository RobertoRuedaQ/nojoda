class AddMentorFieldsToActivitiesDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :activities_details, :mentor_first_name, :string
    add_column :activities_details, :mentor_last_name, :string
    add_column :activities_details, :mentor_identification_number, :string
    add_column :activities_details, :mentor_email, :string
  end
end
