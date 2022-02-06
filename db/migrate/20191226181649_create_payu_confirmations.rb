class CreatePayuConfirmations < ActiveRecord::Migration[5.2]
  def change
    create_table :payu_confirmations do |t|
      t.float :merchant_id
      t.string :state_pol
      t.float :risk
      t.string :response_code_pol
      t.string :reference_sale
      t.string :reference_pol
      t.string :sign
      t.string :extra1
      t.string :extra2
      t.float :payment_method
      t.float :payment_method_type
      t.float :installments_number
      t.float :value
      t.float :tax
      t.float :additional_value
      t.string :transaction_date
      t.string :currency
      t.string :email_buyer
      t.string :cus
      t.string :pse_bank
      t.boolean :test
      t.string :description
      t.string :billing_address
      t.string :shipping_address
      t.string :phone
      t.string :office_phone
      t.string :account_number_ach
      t.string :account_type_ach
      t.float :administrative_fee
      t.float :administrative_fee_base
      t.float :administrative_fee_tax
      t.string :airline_code
      t.float :attempts
      t.string :authorization_code
      t.string :travel_agency_authorization_code
      t.string :bank_id
      t.string :billing_city
      t.string :billing_country
      t.float :commision_pol
      t.string :commision_pol_currency
      t.float :customer_number
      t.string :date
      t.string :error_code_bank
      t.string :error_message_bank
      t.float :exchange_rate
      t.string :ip
      t.string :nickname_buyer
      t.string :nickname_seller
      t.float :payment_method_id
      t.string :payment_request_state
      t.string :psereference1
      t.string :psereference2
      t.string :psereference3
      t.string :response_message_pol
      t.string :shipping_city
      t.string :shipping_country
      t.string :transaction_bank_id
      t.string :transaction_id
      t.string :payment_method_name

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Payu confirmation', object: 'PayuConfirmation',default: true})
attributes = [{:name=>"merchant_id", :type=>:float}, {:name=>"state_pol", :type=>:string}, {:name=>"risk", :type=>:float}, {:name=>"response_code_pol", :type=>:string}, {:name=>"reference_sale", :type=>:string}, {:name=>"reference_pol", :type=>:string}, {:name=>"sign", :type=>:string}, {:name=>"extra1", :type=>:string}, {:name=>"extra2", :type=>:string}, {:name=>"payment_method", :type=>:float}, {:name=>"payment_method_type", :type=>:float}, {:name=>"installments_number", :type=>:float}, {:name=>"value", :type=>:float}, {:name=>"tax", :type=>:float}, {:name=>"additional_value", :type=>:float}, {:name=>"transaction_date", :type=>:string}, {:name=>"currency", :type=>:string}, {:name=>"email_buyer", :type=>:string}, {:name=>"cus", :type=>:string}, {:name=>"pse_bank", :type=>:string}, {:name=>"test", :type=>:boolean}, {:name=>"description", :type=>:string}, {:name=>"billing_address", :type=>:string}, {:name=>"shipping_address", :type=>:string}, {:name=>"phone", :type=>:string}, {:name=>"office_phone", :type=>:string}, {:name=>"account_number_ach", :type=>:string}, {:name=>"account_type_ach", :type=>:string}, {:name=>"administrative_fee", :type=>:float}, {:name=>"administrative_fee_base", :type=>:float}, {:name=>"administrative_fee_tax", :type=>:float}, {:name=>"airline_code", :type=>:string}, {:name=>"attempts", :type=>:float}, {:name=>"authorization_code", :type=>:string}, {:name=>"travel_agency_authorization_code", :type=>:string}, {:name=>"bank_id", :type=>:string}, {:name=>"billing_city", :type=>:string}, {:name=>"billing_country", :type=>:string}, {:name=>"commision_pol", :type=>:float}, {:name=>"commision_pol_currency", :type=>:string}, {:name=>"customer_number", :type=>:float}, {:name=>"date", :type=>:string}, {:name=>"error_code_bank", :type=>:string}, {:name=>"error_message_bank", :type=>:string}, {:name=>"exchange_rate", :type=>:float}, {:name=>"ip", :type=>:string}, {:name=>"nickname_buyer", :type=>:string}, {:name=>"nickname_seller", :type=>:string}, {:name=>"payment_method_id", :type=>:float}, {:name=>"payment_request_state", :type=>:string}, {:name=>"psereference1", :type=>:string}, {:name=>"psereference2", :type=>:string}, {:name=>"psereference3", :type=>:string}, {:name=>"response_message_pol", :type=>:string}, {:name=>"shipping_city", :type=>:string}, {:name=>"shipping_country", :type=>:string}, {:name=>"transaction_bank_id", :type=>:string}, {:name=>"transaction_id", :type=>:string}, {:name=>"payment_method_name", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'payu_confirmations'})
end

  end
end
