class CreateIsaAmendmentDisbursements < ActiveRecord::Migration[5.2]
  def change
    create_table :isa_amendment_disbursements do |t|
      t.references :isa_amendment, foreign_key: true
      t.references :disbursement, foreign_key: true
      t.string :currency
      t.string :disbursement_case
      t.float :student_value
      t.float :company_value
      t.date :forcasted_date
      t.string :status

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Isa amendment disbursement', object: 'IsaAmendmentDisbursement',default: true})
attributes = [{:name=>"isa_amendment", :type=>:references}, {:name=>"disbursement", :type=>:references}, {:name=>"currency", :type=>:string}, {:name=>"disbursement_case", :type=>:string}, {:name=>"student_value", :type=>:float}, {:name=>"company_value", :type=>:float}, {:name=>"forcasted_date", :type=>:date}, {:name=>"status", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'isa_amendment_disbursements'})
end

  end
end
