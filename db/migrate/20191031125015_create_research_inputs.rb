class CreateResearchInputs < ActiveRecord::Migration[5.2]
  def change
    create_table :research_inputs do |t|
      t.string :params_name
      t.string :format
      t.text :description

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Research input', object: 'ResearchInput',default: true})
attributes = [{:name=>"params_name", :type=>:string}, {:name=>"format", :type=>:string}, {:name=>"description", :type=>:text}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'research_inputs'})
end

  end
end
