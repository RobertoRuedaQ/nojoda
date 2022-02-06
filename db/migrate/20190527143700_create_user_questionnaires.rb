class CreateUserQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    create_table :user_questionnaires do |t|
      t.references :user, foreign_key: true
      t.references :questionnaire, foreign_key: true
      t.string :status, index: true, null: false, default: 'pending'
      t.datetime :start_time, index: true
      t.datetime :end_time, index: true
      t.string :result, index: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default User questionnaire', object: 'UserQuestionnaire',default: true})
attributes = [{:name=>"user", :type=>:references}, {:name=>"questionnaire", :type=>:references}, {:name=>"status", :type=>:string}, {:name=>"start_time", :type=>:datetime}, {:name=>"end_time", :type=>:datetime}, {:name=>"result", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'user_questionnaires'})
end

  end
end
