class CreateActivitiesDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :activities_details do |t|
      t.string :detail_case
      t.string :activity_case
      t.string :name
      t.string :category
      t.references :user, foreign_key: true
      t.string :status
      t.date :completiton_date
      t.string :term
      t.float :score
      t.string :url

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Activities detail', object: 'ActivitiesDetail',default: true})
attributes = [{:name=>"detail_case", :type=>:string}, {:name=>"activity_case", :type=>:string}, {:name=>"name", :type=>:string}, {:name=>"category", :type=>:string}, {:name=>"user", :type=>:references}, {:name=>"status", :type=>:string}, {:name=>"completiton_date", :type=>:date}, {:name=>"term", :type=>:string}, {:name=>"score", :type=>:float}, {:name=>"url", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'activities_details'})
end

  end
end
