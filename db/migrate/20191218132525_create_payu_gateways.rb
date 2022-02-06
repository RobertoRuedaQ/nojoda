class CreatePayuGateways < ActiveRecord::Migration[5.2]
  def change
    create_table :payu_gateways do |t|
      t.references :company, foreign_key: true
      t.string :gateway_case
      t.string :api_key
      t.string :api_login
      t.string :account_id
      t.string :merchant_id
      t.string :url
      t.integer :cash_hours
      t.string :name

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Payu gateway', object: 'PayuGateway',default: true})
attributes = [{:name=>"name", :type=>:string},{:name=>"company", :type=>:references}, {:name=>"gateway_case", :type=>:string}, {:name=>"api_key", :type=>:string}, {:name=>"api_login", :type=>:string}, {:name=>"account_id", :type=>:string}, {:name=>"merchant_id", :type=>:string}, {:name=>"url", :type=>:string}, {:name=>"cash_hours", :type=>:integername}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'payu_gateways'})
end

  end
end
