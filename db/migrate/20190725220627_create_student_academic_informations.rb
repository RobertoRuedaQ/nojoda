class CreateStudentAcademicInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :student_academic_informations do |t|
      t.references :user, foreign_key: true
      t.references :institution, foreign_key: true
      t.references :major, foreign_key: true
      t.boolean :other_institution_check
      t.string :other_institution_text
      t.boolean :other_program_check
      t.string :other_program_text
      t.string :score_scale
      t.string :type_of_academic_term
      t.integer :program_number_of_terms
      t.string :current_academic_status
      t.integer :current_term
      t.date :program_start_date
      t.date :expected_graduation_date
      t.date :graduation_date
      t.date :expected_egress_date
      t.date :egress_date
      t.date :expected_diploma_delivery_date
      t.date :diploma_delivery_date
      t.string :degree_obtained
      t.string :last_period_score
      t.boolean :ackn_scholarship_check
      t.boolean :ackn_scholarship_text

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Student academic information', object: 'StudentAcademicInformation',default: true})
attributes = [{:name=>"user", :type=>:references},{:name=>"institution", :type=>:references}, {:name=>"major", :type=>:references}, {:name=>"other_institution_check", :type=>:boolean}, {:name=>"other_institution_text", :type=>:string}, {:name=>"other_program_check", :type=>:boolean}, {:name=>"other_program_text", :type=>:string}, {:name=>"score_scale", :type=>:string}, {:name=>"type_of_academic_term", :type=>:string}, {:name=>"program_number_of_terms", :type=>:integer}, {:name=>"current_academic_status", :type=>:string}, {:name=>"current_term", :type=>:integer}, {:name=>"program_start_date", :type=>:date}, {:name=>"expected_graduation_date", :type=>:date}, {:name=>"graduation_date", :type=>:date}, {:name=>"expected_egress_date", :type=>:date}, {:name=>"egress_date", :type=>:date}, {:name=>"expected_diploma_delivery_date", :type=>:date}, {:name=>"diploma_delivery_date", :type=>:date}, {:name=>"degree_obtained", :type=>:string}, {:name=>"last_period_score", :type=>:string}, {:name=>"ackn_scholarship_check", :type=>:boolean}, {:name=>"ackn_scholarship_text", :type=>:boolean}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'student_academic_informations'})
end

  end
end
