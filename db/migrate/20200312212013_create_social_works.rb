class CreateSocialWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :social_works do |t|
      t.float :number_of_hours
      t.references :user, foreign_key: true
      t.references :country, index: true
      t.references :state, index: true
      t.references :city, index: true
      t.string :term
      t.string :institution_name
      t.text :activities

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Social work', object: 'SocialWork',default: true})
attributes = [{:name=>"number_of_hours", :type=>:float}, {:name=>"country", :type=>:references}, {:name=>"state", :type=>:references}, {:name=>"city", :type=>:references}, {:name=>"term", :type=>:string}, {:name=>"institution_name", :type=>:string}, {:name=>"activities", :type=>:text}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'social_works'})
end

  end
end
