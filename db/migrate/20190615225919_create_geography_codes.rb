class CreateGeographyCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :geography_codes do |t|
      t.string :type
      t.string :value
      t.references :geography, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Geography code', object: 'GeographyCode',default: true})
attributes = [{:name=>"type", :type=>:string}, {:name=>"value", :type=>:string}, {:name=>"geography", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'geography_codes'})
end

  end
end
