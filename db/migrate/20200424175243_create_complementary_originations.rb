class CreateComplementaryOriginations < ActiveRecord::Migration[5.2]
  def change
    create_table :complementary_originations do |t|
      t.references :funding_opportunity, foreign_key: true
      t.references :diploma_delivery, index: true
      t.references :identification_document, index: true
      t.references :grades, index: true
      t.references :academic_stop, index: true
      t.references :financial_adjust, index: true
      t.references :conciliation, index: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Complementary origination', object: 'ComplementaryOrigination',default: true})
attributes = [{:name=>"funding_opportunity", :type=>:references}, {:name=>"diploma_delivery", :type=>:references}, {:name=>"identification_document", :type=>:references}, {:name=>"grades", :type=>:references}, {:name=>"academic_stop", :type=>:references}, {:name=>"financial_adjust", :type=>:references}, {:name=>"anual_income_certification", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'complementary_originations'})
end

  end
end
