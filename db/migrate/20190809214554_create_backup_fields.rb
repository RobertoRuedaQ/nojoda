class CreateBackupFields < ActiveRecord::Migration[5.2]
  def change
    create_table :backup_fields do |t|
      t.string :name
      t.string :label
      t.boolean :calculated
      t.text :notes
      t.string :field_case
      t.string :status
      t.references :backup_object, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Backup field', object: 'BackupField',default: true})
attributes = [{:name=>"name", :type=>:string}, {:name=>"label", :type=>:string}, {:name=>"calculated", :type=>:boolean}, {:name=>"notes", :type=>:text}, {:name=>"field_case", :type=>:string}, {:name=>"status", :type=>:string}, {:name=>"backup_object", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'backup_fields'})
end

  end
end
