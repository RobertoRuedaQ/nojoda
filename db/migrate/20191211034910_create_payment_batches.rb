class CreatePaymentBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_batches do |t|
      t.references :fund, foreign_key: true
      t.integer :month
      t.integer :year

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Payment batch', object: 'PaymentBatch',default: true})
attributes = [{:name=>"fund", :type=>:references}, {:name=>"month", :type=>:integer}, {:name=>"year", :type=>:integer}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'payment_batches'})
end

  end
end
