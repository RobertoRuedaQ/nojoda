class CreateModelingFlowFees < ActiveRecord::Migration[5.2]
  def change
    create_table :modeling_flow_fees do |t|
      t.float :detail_fee
      t.float :tax
      t.references :modeling_fee, foreign_key: true
      t.references :modeling_flow, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Modeling flow fee', object: 'ModelingFlowFee',default: true})
attributes = [{:name=>"detail_fee", :type=>:float}, {:name=>"tax", :type=>:float}, {:name=>"modeling_fee", :type=>:references}, {:name=>"modeling_flow", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'modeling_flow_fees'})
end

  end
end
