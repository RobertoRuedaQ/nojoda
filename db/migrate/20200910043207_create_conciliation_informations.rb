class CreateConciliationInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :conciliation_informations do |t|
      t.date :start_date
      t.date :end_date
      t.integer :year
      t.float :total_income

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Conciliation information', object: 'ConciliationInformation',default: true})
attributes = [{:name=>"start_date", :type=>:date}, {:name=>"end_date", :type=>:date}, {:name=>"year", :type=>:integer}, {:name=>"total_income", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'conciliation_informations'})
end

  end
end
