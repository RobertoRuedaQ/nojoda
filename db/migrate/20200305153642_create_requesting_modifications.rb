class CreateRequestingModifications < ActiveRecord::Migration[5.2]
  def change
    create_table :requesting_modifications do |t|
      t.references :application, foreign_key: true
      t.string :status
      t.text :changes_description
      t.date :deadline

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Requesting modification', object: 'RequestingModification',default: true})
attributes = [{:name=>"application", :type=>:references}, {:name=>"status", :type=>:string}, {:name=>"changes_description", :type=>:text}, {:name=>"deadline", :type=>:date}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'requesting_modifications'})
end

  end
end
