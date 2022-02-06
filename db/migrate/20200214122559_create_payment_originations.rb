class CreatePaymentOriginations < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_originations do |t|
      t.boolean :debit_card
      t.boolean :cash
      t.boolean :credit_card
      t.boolean :bank_transfer
      t.boolean :manual_payment
      t.references :manual_payment_origination, index: true
      t.references :company, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Payment origination', object: 'PaymentOrigination',default: true})
attributes = [{:name=>"debit_card", :type=>:boolean}, {:name=>"cash", :type=>:boolean}, {:name=>"credit_card", :type=>:boolean}, {:name=>"bank_transfer", :type=>:boolean}, {:name=>"manual_payment", :type=>:boolean}, {:name=>"manual_payment_origination", :type=>:references}, {:name=>"company", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'payment_originations'})
end

  end
end
