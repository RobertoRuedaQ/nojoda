class CreatePaymentExcesses < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_excesses do |t|
      t.references :user, foreign_key: true
      t.references :payment, foreign_key: true
      t.float :value
      t.string :status

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Payment excess', object: 'PaymentExcess',default: true})
attributes = [{:name=>"user", :type=>:references}, {:name=>"payment", :type=>:references}, {:name=>"value", :type=>:float}, {:name=>"status", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'payment_excesses'})
end

  end
end
