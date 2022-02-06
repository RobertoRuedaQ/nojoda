class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :billing_document, foreign_key: true
      t.string :status
      t.boolean :matching_problem_check
      t.string :matching_problem_case
      t.string :payment_source
      t.string :payment_method
      t.string :value

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Payment', object: 'Payment',default: true})
attributes = [{:name=>"billing_document", :type=>:references}, {:name=>"status", :type=>:string}, {:name=>"matching_problem_check", :type=>:boolean}, {:name=>"matching_problem_case", :type=>:string}, {:name=>"payment_source", :type=>:string}, {:name=>"payment_method", :type=>:string}, {:name=>"value", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'payments'})
end

  end
end
