class CreateUniversityGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :university_grades do |t|
      t.references :student_academic_information, foreign_key: true
      t.string :grade
      t.string :term

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default University grade', object: 'UniversityGrade',default: true})
attributes = [{:name=>"student_academic_information", :type=>:references}, {:name=>"grade", :type=>:string}, {:name=>"term", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'university_grades'})
end

  end
end
