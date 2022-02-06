class CreateModelingFlowDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :modeling_flow_details do |t|
      t.integer :year
      t.integer :month
      t.string :flow_case
      t.references :funding_option, foreign_key: true
      t.references :modeling, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Modeling flow detail', object: 'ModelingFlowDetail',default: true})
attributes = [{:name=>"year", :type=>:integer}, {:name=>"month", :type=>:integer}, {:name=>"flow_case", :type=>:string}, {:name=>"funding_option", :type=>:references}, {:name=>"modeling", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'modeling_flow_details'})
end

  end
end
