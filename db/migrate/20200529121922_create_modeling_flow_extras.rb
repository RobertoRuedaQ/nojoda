class CreateModelingFlowExtras < ActiveRecord::Migration[5.2]
  def change
    create_table :modeling_flow_extras do |t|
      t.references :modeling_flow, foreign_key: true
      t.integer :repayment_period
      t.float :prob_p10
      t.float :prob_p20
      t.float :prob_p30
      t.float :prob_p40
      t.float :prob_p50
      t.float :prob_p60
      t.float :prob_p70
      t.float :prob_p80
      t.float :prob_p90
      t.float :repay_p10
      t.float :repay_p20
      t.float :repay_p30
      t.float :repay_p40
      t.float :repay_p50
      t.float :repay_p60
      t.float :repay_p70
      t.float :repay_p80
      t.float :repay_p90
      t.float :culture_payment
      t.float :real_collection
      t.float :growth_p10
      t.float :growth_p20
      t.float :growth_p30
      t.float :growth_p40
      t.float :growth_p50
      t.float :growth_p60
      t.float :growth_p70
      t.float :growth_p80
      t.float :growth_p90
      t.float :risk_adjustment
      t.float :outflows
      t.float :tuition
      t.float :living_expenses
      t.float :repayments
      t.float :inflows
      t.float :fees
      t.float :taxes
      t.float :hurdle
      t.float :pv_target_flow
      t.float :cumulative_pv_target_flow
      t.float :adjustment

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Modeling flow extra', object: 'ModelingFlowExtra',default: true})
attributes = [{:name=>"modeling_flow", :type=>:references}, {:name=>"repayment_period", :type=>:integer}, {:name=>"prob_p10", :type=>:float}, {:name=>"prob_p20", :type=>:float}, {:name=>"prob_p30", :type=>:float}, {:name=>"prob_p40", :type=>:float}, {:name=>"prob_p50", :type=>:float}, {:name=>"prob_p60", :type=>:float}, {:name=>"prob_p70", :type=>:float}, {:name=>"prob_p80", :type=>:float}, {:name=>"prob_p90", :type=>:float}, {:name=>"repay_p10", :type=>:float}, {:name=>"repay_p20", :type=>:float}, {:name=>"repay_p30", :type=>:float}, {:name=>"repay_p40", :type=>:float}, {:name=>"repay_p50", :type=>:float}, {:name=>"repay_p60", :type=>:float}, {:name=>"repay_p70", :type=>:float}, {:name=>"repay_p80", :type=>:float}, {:name=>"repay_p90", :type=>:float}, {:name=>"culture_payment", :type=>:float}, {:name=>"real_collection", :type=>:float}, {:name=>"growth_p10", :type=>:float}, {:name=>"growth_p20", :type=>:float}, {:name=>"growth_p30", :type=>:float}, {:name=>"growth_p40", :type=>:float}, {:name=>"growth_p50", :type=>:float}, {:name=>"growth_p60", :type=>:float}, {:name=>"growth_p70", :type=>:float}, {:name=>"growth_p80", :type=>:float}, {:name=>"growth_p90", :type=>:float}, {:name=>"risk_adjustment", :type=>:float}, {:name=>"outflows", :type=>:float}, {:name=>"tuition", :type=>:float}, {:name=>"living_expenses", :type=>:float}, {:name=>"repayments", :type=>:float}, {:name=>"inflows", :type=>:float}, {:name=>"fees", :type=>:float}, {:name=>"taxes", :type=>:float}, {:name=>"hurdle", :type=>:float}, {:name=>"pv_target_flow", :type=>:float}, {:name=>"cumulative_pv_target_flow", :type=>:float}, {:name=>"adjustment", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'modeling_flow_extras'})
end

  end
end
