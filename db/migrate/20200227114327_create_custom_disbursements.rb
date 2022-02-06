class CreateCustomDisbursements < ActiveRecord::Migration[5.2]
  def change
    create_table :custom_disbursements do |t|
      t.references :modeling, foreign_key: true
      t.float :currency
      t.string :disbursement_case
      t.float :student_value
      t.float :company_value
      t.date :forcasted_date

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Custom disbursements', object: 'CustomDisbursement',default: true})
attributes = [{:name=>"modeling", :type=>:references}, {:name=>"currency", :type=>:float}, {:name=>"disbursement_case", :type=>:string}, {:name=>"student_value", :type=>:float}, {:name=>"company_value", :type=>:float}, {:name=>"forcasted_date", :type=>:date}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'custom_disbursements'})
end

  end
end
