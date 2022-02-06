class CreateMigrationPicklists < ActiveRecord::Migration[5.2]
  def change
    create_table :migration_picklists do |t|
      t.references :migration_field, foreign_key: true
      t.string :sf_value
      t.string :rails_value
      t.string :label_spanish
      t.string :label_english

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Migration picklist', object: 'MigrationPicklist',default: true})
attributes = [{:name=>"migration_field", :type=>:references}, {:name=>"sf_value", :type=>:string}, {:name=>"rails_value", :type=>:string}, {:name=>"label_spanish", :type=>:string}, {:name=>"label_english", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'migration_picklists'})
end

  end
end
