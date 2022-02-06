class CreateResearchModelInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :research_model_infos do |t|
      t.references :research_variable, foreign_key: true
      t.string :hash
      t.float :value
      t.string :info_format

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Research model info', object: 'ResearchModelInfo',default: true})
attributes = [{:name=>"research_variable", :type=>:references}, {:name=>"hash", :type=>:string}, {:name=>"value", :type=>:float}, {:name=>"info_format", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'research_model_infos'})
end

  end
end
