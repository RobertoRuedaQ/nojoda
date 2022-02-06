class CreateAcademicStops < ActiveRecord::Migration[5.2]
  def change
    create_table :academic_stops do |t|
      t.references :student_academic_information, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :status

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Academic stop', object: 'AcademicStop',default: true})
attributes = [{:name=>"student_academic_information", :type=>:references}, {:name=>"start_date", :type=>:date}, {:name=>"end_date", :type=>:date}, {:name=>"status", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'academic_stops'})
end

  end
end
