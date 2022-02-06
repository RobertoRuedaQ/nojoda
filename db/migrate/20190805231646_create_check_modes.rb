class CreateCheckModes < ActiveRecord::Migration[5.2]
  def change
    create_table :check_modes do |t|
      t.references :check_field, foreign_key: true
      t.string :label
      t.integer :frequency

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Check mode', object: 'CheckMode',default: true})
attributes = [{:name=>"check_field", :type=>:references}, {:name=>"label", :type=>:string}, {:name=>"frequency", :type=>:integer}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'check_modes'})
end

  end
end
