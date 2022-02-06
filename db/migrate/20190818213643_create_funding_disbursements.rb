class CreateFundingDisbursements < ActiveRecord::Migration[5.2]
  def change
    create_table :funding_disbursements do |t|
      t.float :max_total_fundinding_value
      t.float :max_funding_by_disbursement
      t.integer :max_disbursement_periods
      t.float :growth_rate
      t.string :disbursement_case

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Funding disbursement', object: 'FundingDisbursement',default: true})
attributes = [{:name=>"max_total_fundinding_value", :type=>:float}, {:name=>"max_funding_by_disbursement", :type=>:float}, {:name=>"max_disbursement_periods", :type=>:integer}, {:name=>"growth_rate", :type=>:float}, {:name=>"disbursement_case", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'funding_disbursements'})
end

  end
end
