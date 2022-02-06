class CreateCommunicationUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :communication_users do |t|
      t.references :user, foreign_key: true
      t.string :from_field
      t.string :to_field
      t.string :subject
      t.text :body
      t.boolean :read_field
      t.string :category

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Communication user', object: 'CommunicationUser',default: true})
attributes = [{:name=>"user", :type=>:references}, {:name=>"from_field", :type=>:string}, {:name=>"to_field", :type=>:string}, {:name=>"subject", :type=>:string}, {:name=>"body", :type=>:text}, {:name=>"read_field", :type=>:boolean}, {:name=>"category", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'communication_users'})
end

  end
end
