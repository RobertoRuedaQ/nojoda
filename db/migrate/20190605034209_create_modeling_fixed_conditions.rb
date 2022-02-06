class CreateModelingFixedConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :modeling_fixed_conditions do |t|
      t.float :student_percentaje
      t.float :graduated_percentage
      t.integer :term
      t.float :nominal_payment
      t.string :cap_type

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Modeling fixed conditions', object: 'ModelingFixedCondition',default: true})
attributes = [{:name=>"student_percentaje", :type=>:float}, {:name=>"graduated_percentage", :type=>:float}, {:name=>"term", :type=>:integer}, {:name=>"nominal_payment", :type=>:float}, {:name=>"cap_type", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'modeling_fixed_conditions'})
end

  end
end
