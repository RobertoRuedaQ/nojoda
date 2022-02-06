class CreateStudentReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :student_reviews do |t|
      t.references :user, foreign_key: true
      t.date :report_date
      t.text :comments
      t.references :created_by, index: true
      t.string :state

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Student review', object: 'StudentReview',default: true})
attributes = [{:name=>"user", :type=>:references}, {:name=>"report_date", :type=>:date}, {:name=>"comments", :type=>:text}, {:name=>"created_by", :type=>:references}, {:name=>"state", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'student_reviews'})
end

  end
end
