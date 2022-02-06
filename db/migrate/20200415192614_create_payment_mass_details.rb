class CreatePaymentMassDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_mass_details do |t|
      t.references :payment, foreign_key: true
      t.references :payment_mass, foreign_key: true
      t.references :billing_document, foreign_key: true
      t.string :bank_number
      t.string :ref_1
      t.string :ref_2
      t.float :value
      t.date :transaction_date
      t.string :office
      t.string :city
      t.text :description

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Payment mass detail', object: 'PaymentMassDetail',default: true})
attributes = [{:name=>"payment", :type=>:references}, {:name=>"payment_mass", :type=>:references}, {:name=>"billing_document", :type=>:references}, {:name=>"bank_number", :type=>:string}, {:name=>"ref_1", :type=>:string}, {:name=>"ref_2", :type=>:string}, {:name=>"value", :type=>:float}, {:name=>"transaction_date", :type=>:date}, {:name=>"office", :type=>:string}, {:name=>"city", :type=>:string}, {:name=>"description", :type=>:text}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'payment_mass_details'})
end

  end
end
