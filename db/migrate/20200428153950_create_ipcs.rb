class CreateIpcs < ActiveRecord::Migration[5.2]
  def change
    create_table :ipcs do |t|
      t.integer :year
      t.integer :month
      t.float :value
      t.references :country, foreign_key: true
      t.float :monthly_variation
      t.float :annual_variation
      t.float :cumulative_variation

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Ipc', object: 'Ipc',default: true})
attributes = [{:name=>"year", :type=>:integer}, {:name=>"month", :type=>:integer}, {:name=>"value", :type=>:float}, {:name=>"country", :type=>:references}, {:name=>"monthly_variation", :type=>:float}, {:name=>"annual_variation", :type=>:float}, {:name=>"cumulative_variation", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'ipcs'})
end

  end
end
