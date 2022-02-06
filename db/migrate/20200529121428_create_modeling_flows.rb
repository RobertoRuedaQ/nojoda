class CreateModelingFlows < ActiveRecord::Migration[5.2]
  def change
    create_table :modeling_flows do |t|
      t.references :modeling, foreign_key: true
      t.references :funding_option, foreign_key: true
      t.string :flow_case

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Modeling flow', object: 'ModelingFlow',default: true})
attributes = [{:name=>"modeling", :type=>:references}, {:name=>"funding_option", :type=>:references}, {:name=>"flow_case", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'modeling_flows'})
end

  end
end
