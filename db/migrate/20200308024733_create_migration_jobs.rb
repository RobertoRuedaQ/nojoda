class CreateMigrationJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :migration_jobs do |t|
      t.references :migration, foreign_key: true
      t.string :target_array
      t.string :status
      t.integer :target_record_number

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Migration job', object: 'MigrationJob',default: true})
attributes = [{:name=>"migration", :type=>:references}, {:name=>"target_array", :type=>:string}, {:name=>"status", :type=>:string}, {:name=>"target_record_number", :type=>:integer}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'migration_jobs'})
end

  end
end
