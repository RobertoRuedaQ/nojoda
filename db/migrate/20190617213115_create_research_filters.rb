class CreateResearchFilters < ActiveRecord::Migration[5.2]
  def change
    create_table :research_filters do |t|
      t.references :variable, index: true
      t.references :filter, index: true
      t.integer :order
      t.string :acronym
      t.references :country, foreign_key: true
      t.integer :level

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Research filter', object: 'ResearchFilter',default: true})
attributes = [{:name=>"variable", :type=>:references}, {:name=>"filter", :type=>:references}, {:name=>"order", :type=>:integer}, {:name=>"acronym", :type=>:string}, {:name=>"country", :type=>:references}, {:name=>"level", :type=>:integer}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'research_filters'})
end

  end
end
