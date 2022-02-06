class CreateHealths < ActiveRecord::Migration[5.2]
  def change
    create_table :healths do |t|
      t.boolean :disability_check
      t.boolean :Inpatient_check
      t.boolean :emergency_room_check
      t.boolean :consumption_of_narcotic_check
      t.boolean :diseases_check
      t.text :diseases_text
      t.text :disability_text
      t.references :user, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Health', object: 'Health',default: true})
attributes = [{:name=>"disability_check", :type=>:boolean}, {:name=>"Inpatient_check", :type=>:boolean}, {:name=>"emergency_room_check", :type=>:boolean}, {:name=>"consumption_of_narcotic_check", :type=>:boolean}, {:name=>"diseases_check", :type=>:boolean}, {:name=>"diseases_text", :type=>:text}, {:name=>"disability_text", :type=>:text}, {:name=>"user", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'healths'})
end

  end
end
