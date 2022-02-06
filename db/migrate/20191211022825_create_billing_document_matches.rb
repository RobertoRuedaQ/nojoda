class CreateBillingDocumentMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :billing_document_matches do |t|
      t.references :resource, polymorphic: true, index: true
      t.references :billing_document_details, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Billing document match', object: 'BillingDocumentMatch',default: true})
attributes = [{:name=>"resource", :type=>:references}, {:name=>"billing_document_details", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'billing_document_matches'})
end

  end
end
