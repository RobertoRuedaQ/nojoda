class CreateCheckObjects < ActiveRecord::Migration[5.2]
  def change
    create_table :check_objects do |t|
      t.string :name
      t.string :label
      t.boolean :custom
      t.integer :rows
      t.boolean :migrate
      t.text :notes

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Check object', object: 'CheckObject',default: true})
attributes = [{:name=>"name", :type=>:string}, {:name=>"label", :type=>:string}, {:name=>"custom", :type=>:boolean}, {:name=>"rows", :type=>:integer}, {:name=>"migrate", :type=>:boolean}, {:name=>"notes", :type=>:text}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'check_objects'})
end

  end
end
