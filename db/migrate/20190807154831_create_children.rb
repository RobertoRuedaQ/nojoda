class CreateChildren < ActiveRecord::Migration[5.2]
  def change
    create_table :children do |t|
      t.date :birthday
      t.string :gender
      t.string :academic_level
      t.string :name
      t.references :user, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Child', object: 'Child',default: true})
attributes = [{:name=>"birthday", :type=>:date}, {:name=>"gender", :type=>:string}, {:name=>"academic_level", :type=>:string}, {:name=>"name", :type=>:string}, {:name=>"user", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'children'})
end

  end
end
