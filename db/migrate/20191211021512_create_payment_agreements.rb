class CreatePaymentAgreements < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_agreements do |t|
      t.float :value
      t.float :rate
      t.integer :number_payments
      t.string :status
      t.string :agreement_case

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Payment agreement', object: 'PaymentAgreement',default: true})
attributes = [{:name=>"value", :type=>:float}, {:name=>"rate", :type=>:float}, {:name=>"number_payments", :type=>:integer}, {:name=>"status", :type=>:string}, {:name=>"agreement_case", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'payment_agreements'})
end

  end
end
