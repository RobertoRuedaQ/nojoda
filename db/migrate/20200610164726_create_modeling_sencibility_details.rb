class CreateModelingSencibilityDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :modeling_sencibility_details do |t|
      t.references :modeling_sencibility, foreign_key: true
      t.references :funding_option, foreign_key: true
      t.integer :term
      t.float :study_percentage
      t.float :graduated_percentage

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Modeling sencibility detail', object: 'ModelingSencibilityDetail',default: true})
attributes = [{:name=>"modeling_sencibility", :type=>:references}, {:name=>"funding_option", :type=>:references}, {:name=>"term", :type=>:integer}, {:name=>"study_percentage", :type=>:float}, {:name=>"graduated_percentage", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'modeling_sencibility_details'})
end

  end
end
