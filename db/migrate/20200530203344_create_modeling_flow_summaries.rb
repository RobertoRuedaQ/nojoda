class CreateModelingFlowSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :modeling_flow_summaries do |t|
      t.references :modeling_flow, foreign_key: true
      t.float :desembolsos
      t.float :repagos
      t.float :retorno
      t.float :comisiones
      t.float :upper_factor
      t.float :lower_factor
      t.float :middle_factor
      t.string :step
      t.string :algorithm
      t.float :row_cashflow

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Modeling flow summary', object: 'ModelingFlowSummary',default: true})
attributes = [{:name=>"modeling_flow", :type=>:references}, {:name=>"desembolsos", :type=>:float}, {:name=>"repagos", :type=>:float}, {:name=>"retorno", :type=>:float}, {:name=>"comisiones", :type=>:float}, {:name=>"upper_factor", :type=>:float}, {:name=>"lower_factor", :type=>:float}, {:name=>"middle_factor", :type=>:float}, {:name=>"step", :type=>:string}, {:name=>"algorithm", :type=>:string}, {:name=>"row_cashflow", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'modeling_flow_summaries'})
end

  end
end
