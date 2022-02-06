class CreateSchoolInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :school_infos do |t|
      t.references :student_academic_information, foreign_key: true
      t.boolean :academic_bonus_granted
      t.string :shift
      t.integer :number_subjects_taken
      t.integer :number_subjects_failed
      t.boolean :problems_with_subjects_check
      t.string :problems_with_subjects_text

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default School info', object: 'SchoolInfo',default: true})
attributes = [{:name=>"student_academic_information", :type=>:references}, {:name=>"academic_bonus_granted", :type=>:boolean}, {:name=>"shift", :type=>:string}, {:name=>"number_subjects_taken", :type=>:integer}, {:name=>"number_subjects_failed", :type=>:integer}, {:name=>"problems_with_subjects_check", :type=>:boolean}, {:name=>"problems_with_subjects_text", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'school_infos'})
end

  end
end
