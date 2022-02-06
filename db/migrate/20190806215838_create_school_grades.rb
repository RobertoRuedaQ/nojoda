class CreateSchoolGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :school_grades do |t|
      t.string :year
      t.string :mathematics
      t.string :phisics
      t.string :chemistry
      t.string :social_studies
      t.string :biology
      t.string :language
      t.string :behavior
      t.references :student_academic_information, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default School grades', object: 'SchoolGrade',default: true})
attributes = [{:name=>"year", :type=>:string}, {:name=>"mathematics", :type=>:string}, {:name=>"phisics", :type=>:string}, {:name=>"chemistry", :type=>:string}, {:name=>"social_studies", :type=>:string}, {:name=>"biology", :type=>:string}, {:name=>"language", :type=>:string}, {:name=>"behavior", :type=>:string}, {:name=>"student_academic_information", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'school_grades'})
end

  end
end
