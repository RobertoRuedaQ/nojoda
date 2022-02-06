class CreateDisbursementRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :disbursement_requests do |t|
      t.references :application, foreign_key: true
      t.float :tuition_value
      t.float :requested_value
      t.string :status
      t.date :due_date
      t.string :request_case
      t.float :value_payed_by_student

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Disbursement request', object: 'DisbursementRequest',default: true})
attributes = [{:name=>"application", :type=>:references}, {:name=>"tuition_value", :type=>:float}, {:name=>"requested_value", :type=>:float}, {:name=>"status", :type=>:string}, {:name=>"due_date", :type=>:date}, {:name=>"request_case", :type=>:string}, {:name=>"value_payed_by_student", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'disbursement_requests'})
end

  end
end
