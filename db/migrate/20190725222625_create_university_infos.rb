class CreateUniversityInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :university_infos do |t|
      t.references :student_academic_information, foreign_key: true
      t.boolean :school_year_failed_check
      t.string :school_year_failed_text
      t.string :average_score
      t.boolean :problem_at_school_check
      t.string :problem_at_school_text
      t.boolean :accepted_in_university
      t.boolean :reprimands_for_low_assistance
      t.boolean :planning_to_take_preuniversity_classes

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default University info', object: 'UniversityInfo',default: true})
attributes = [{:name=>"student_academic_information", :type=>:references}, {:name=>"school_year_failed_check", :type=>:boolean}, {:name=>"school_year_failed_text", :type=>:string}, {:name=>"average_score", :type=>:string}, {:name=>"problem_at_school_check", :type=>:boolean}, {:name=>"problem_at_school_text", :type=>:string}, {:name=>"accepted_in_university", :type=>:boolean}, {:name=>"reprimands_for_low_assistance", :type=>:boolean}, {:name=>"planning_to_take_preuniversity_classes", :type=>:boolean}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'university_infos'})
end

  end
end
