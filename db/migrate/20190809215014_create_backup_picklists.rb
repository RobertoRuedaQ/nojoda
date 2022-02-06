class CreateBackupPicklists < ActiveRecord::Migration[5.2]
  def change
    create_table :backup_picklists do |t|
      t.boolean :active
      t.boolean :default_value
      t.string :label
      t.string :value
      t.references :backup_field, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Backup picklist', object: 'BackupPicklist',default: true})
attributes = [{:name=>"active", :type=>:boolean}, {:name=>"default_value", :type=>:boolean}, {:name=>"label", :type=>:string}, {:name=>"value", :type=>:string}, {:name=>"backup_field", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'backup_picklists'})
end

  end
end
