class CreateModelingMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :modeling_matches do |t|
      t.references :application, foreign_key: true
      t.references :reference, polymorphic: true, index: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Modeling match', object: 'ModelingMatch',default: true})
attributes = [{:name=>"application", :type=>:references}, {:name=>"reference", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'modeling_matches'})
end

  end
end
