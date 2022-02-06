class CreateApiHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :api_histories do |t|
      t.string :url
      t.string :context
      t.text :response
      t.string :status
      t.float :response_time
      t.references :user, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Api history', object: 'ApiHistory',default: true})
attributes = [{:name=>"url", :type=>:string}, {:name=>"context", :type=>:string}, {:name=>"response", :type=>:text}, {:name=>"status", :type=>:string}, {:name=>"response_time", :type=>:float}, {:name=>"user", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'api_histories'})
end

  end
end
