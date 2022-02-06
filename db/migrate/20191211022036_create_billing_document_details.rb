class CreateBillingDocumentDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :billing_document_details do |t|
      t.references :billing_document_detail, foreign_key: true
      t.string :status
      t.integer :year
      t.integer :month
      t.float :payment_equivalency
      t.float :value

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Billing document detail', object: 'BillingDocumentDetail',default: true})
attributes = [{:name=>"billing_document_detail", :type=>:references}, {:name=>"status", :type=>:string}, {:name=>"year", :type=>:integer}, {:name=>"month", :type=>:integer}, {:name=>"payment_equivalency", :type=>:float}, {:name=>"value", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'billing_document_details'})
end

  end
end
