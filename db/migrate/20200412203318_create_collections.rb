class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.references :user, foreign_key: true
      t.string :stage
      t.string :contact_person
      t.string :communication_chanel
      t.string :action
      t.string :case
      t.string :result
      t.string :value
      t.date :following_date
      t.string :reason_not_payment
      t.text :comments

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Collection', object: 'Collection',default: true})
attributes = [{:name=>"user", :type=>:references}, {:name=>"stage", :type=>:string}, {:name=>"contact_person", :type=>:string}, {:name=>"communication_chanel", :type=>:string}, {:name=>"action", :type=>:string}, {:name=>"case", :type=>:string}, {:name=>"result", :type=>:string}, {:name=>"value", :type=>:string}, {:name=>"following_date", :type=>:date}, {:name=>"reason_not_payment", :type=>:string}, {:name=>"comments", :type=>:text}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'collections'})
end

  end
end
