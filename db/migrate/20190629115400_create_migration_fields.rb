class CreateMigrationFields < ActiveRecord::Migration[5.2]
  def change
    create_table :migration_fields do |t|
      t.string :sf_field
      t.string :model_field
      t.string :model_reference
      t.string :function_text
      t.string :type_of_field
      t.references :migration, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Migration fields', object: 'MigrationField',default: true})
attributes = [{:name=>"sf_field", :type=>:string}, {:name=>"model_field", :type=>:string}, {:name=>"model_reference", :type=>:string}, {:name=>"function_text", :type=>:string}, {:name=>"type_of_field", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'migration_fields'})
end

  end
end
