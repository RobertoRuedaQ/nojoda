class CreatePaymentConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_configs do |t|
      t.references :funding_opportunity, foreign_key: true
      t.float :conciliation_rate
      t.float :normalization_rate
      t.float :termination_rate
      t.float :arrears_rate
      t.integer :payments_to_default

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Payment config', object: 'PaymentConfig',default: true})
attributes = [{:name=>"funding_opportunity", :type=>:references}, {:name=>"conciliation_rate", :type=>:float}, {:name=>"normalization_rate", :type=>:float}, {:name=>"termination_rate", :type=>:float}, {:name=>"arrears_rate", :type=>:float}, {:name=>"payments_to_default", :type=>:integer}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'payment_configs'})
end

  end
end
