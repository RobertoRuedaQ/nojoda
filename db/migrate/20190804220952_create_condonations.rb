class CreateCondonations < ActiveRecord::Migration[5.2]
  def change
    create_table :condonations do |t|
      t.references :disbursement, foreign_key: true
      t.references :resource, polymorphic: true, index: true
      t.string :cancellation_case
      t.float :cancelation_value

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Condonation', object: 'Condonation',default: true})
attributes = [{:name=>"disbursement", :type=>:references}, {:name=>"resource", :type=>:references}, {:name=>"cancellation_case", :type=>:string}, {:name=>"cancelation_value", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'condonations'})
end

  end
end
