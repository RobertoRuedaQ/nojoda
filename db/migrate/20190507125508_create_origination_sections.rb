class CreateOriginationSections < ActiveRecord::Migration[5.2]
  def change
    create_table :origination_sections do |t|
      t.references :origination_module, foreign_key: true
      t.references :resource, polymorphic: true, index: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Origination section', object: 'OriginationSection',default: true})
attributes = [{:name=>"origination_module", :type=>:references}, {:name=>"resource", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'origination_sections'})
end

  end
end
