class CreateProjectTaskTranslates < ActiveRecord::Migration[5.2]
  def change
    create_table :project_task_translates do |t|
      t.string :name
      t.text :description
      t.string :language
      t.references :project_task_type, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Project task translate', object: 'ProjectTaskTranslate',default: true})
attributes = [{:name=>"name", :type=>:string}, {:name=>"description", :type=>:text}, {:name=>"language", :type=>:string}, {:name=>"project_task_type", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'project_task_translates'})
end

  end
end
