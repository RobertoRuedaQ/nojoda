class CreateInfoTerpels < ActiveRecord::Migration[5.2]
  def change
    create_table :info_terpels do |t|
      t.string :applicant_case
      t.string :gas_station_case
      t.string :gas_station_name
      t.string :escuderia_case

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Info terpel', object: 'InfoTerpel',default: true})
attributes = [{:name=>"applicant_case", :type=>:string}, {:name=>"gas_station_case", :type=>:string}, {:name=>"gas_station_name", :type=>:string}, {:name=>"escuderia_case", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'info_terpels'})
end

  end
end
