class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.string :controller
      t.string :action
      t.integer :feedback_id
      t.references :feedback, foreign_key: true
      t.references :autor, index: true
      t.string :status
      t.string :title
      t.text :body
      t.string :feedback_case

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Feedback', object: 'Feedback',default: true})
attributes = [{:name=>"controller", :type=>:string}, {:name=>"action", :type=>:string}, {:name=>"feedback_id", :type=>:integer}, {:name=>"feedback", :type=>:references}, {:name=>"autor", :type=>:references}, {:name=>"status", :type=>:string}, {:name=>"title", :type=>:string}, {:name=>"body", :type=>:text}, {:name=>"feedback_case", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'feedbacks'})
end

  end
end
