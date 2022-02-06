class CreateDisbursements < ActiveRecord::Migration[5.2]
  def change
    create_table :disbursements do |t|
      t.references :funding_option, foreign_key: true
      t.references :resource, polymorphic: true, index: true
      t.string :currency
      t.string :disbursement_case
      t.float :student_value
      t.float :company_value
      t.date :forcasted_date
      t.float :forcasted_value
      t.boolean :request_tuition_support
      t.integer :disbursement_number
      t.float :clearance_value

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Disbursement', object: 'Disbursement',default: true})
attributes = [{:name=>"funding_option", :type=>:references}, {:name=>"resource", :type=>:references}, {:name=>"currency", :type=>:string}, {:name=>"disbursement_case", :type=>:string}, {:name=>"student_value", :type=>:float}, {:name=>"company_value", :type=>:float}, {:name=>"forcasted_date", :type=>:date}, {:name=>"forcasted_value", :type=>:float}, {:name=>"request_tuition_support", :type=>:boolean}, {:name=>"disbursement_number", :type=>:integer}, {:name=>"clearance_value", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'disbursements'})
end

  end
end
