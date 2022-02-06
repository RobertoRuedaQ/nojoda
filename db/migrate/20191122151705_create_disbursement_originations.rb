class CreateDisbursementOriginations < ActiveRecord::Migration[5.2]
  def change
    create_table :disbursement_originations do |t|
      t.integer :max_request_by_disbursement
      t.float :percentage_previous_tuition
      t.float :percentage_next_tuition
      t.float :percentage_previous_living_expenses
      t.float :percentage_next_living_expenses
      t.references :company, foreign_key: true
      t.references :origination, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Disbursement origination', object: 'DisbursementOrigination',default: true})
attributes = [{:name=>"max_request_by_disbursement", :type=>:integer}, {:name=>"percentage_previous_tuition", :type=>:float}, {:name=>"percentage_next_tuition", :type=>:float}, {:name=>"percentage_previous_living_expenses", :type=>:float}, {:name=>"percentage_next_living_expenses", :type=>:float}, {:name=>"company", :type=>:references}, {:name=>"origination", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'disbursement_originations'})
end

  end
end
