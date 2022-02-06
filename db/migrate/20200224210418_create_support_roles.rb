class CreateSupportRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :support_roles do |t|
      t.string :role_case
      t.text :role_description
      t.string :role_status

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Support roles', object: 'SupportRole',default: true})
attributes = [{:name=>"role_case", :type=>:string}, {:name=>"role_description", :type=>:text}, {:name=>"role_status", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'support_roles'})
end

  end
end
