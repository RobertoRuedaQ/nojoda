class CreateDocsNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :docs_notes do |t|
      t.references :docs_general, foreign_key: true
      t.text :description
      t.references :user, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Docs notes', object: 'DocsNote',default: true})
attributes = [{:name=>"docs_general", :type=>:references}, {:name=>"description", :type=>:text}, {:name=>"user", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'docs_notes'})
end

  end
end
