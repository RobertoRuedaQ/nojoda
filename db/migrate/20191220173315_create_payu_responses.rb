class CreatePayuResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :payu_responses do |t|
      t.string :code
      t.string :error
      t.integer :order_id
      t.string :transaction_id
      t.string :state
      t.string :response_code
      t.string :payment_network_response_code
      t.string :payment_network_response_error_message
      t.string :trazability_code
      t.string :authorization_code
      t.string :response_message
      t.date :operation_date

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Payu response', object: 'PayuResponse',default: true})
attributes = [{:name=>"code", :type=>:string}, {:name=>"error", :type=>:string}, {:name=>"order_id", :type=>:integer}, {:name=>"transaction_id", :type=>:string}, {:name=>"state", :type=>:string}, {:name=>"response_code", :type=>:string}, {:name=>"payment_network_response_code", :type=>:string}, {:name=>"payment_network_response_error_message", :type=>:string}, {:name=>"trazability_code", :type=>:string}, {:name=>"authorization_code", :type=>:string}, {:name=>"response_message", :type=>:string}, {:name=>"operation_date", :type=>:date}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'payu_responses'})
end

  end
end
