class CreateCancellationConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :cancellation_configs do |t|
      t.string :record_type
      t.references :fund, foreign_key: true
      t.string :cancellation_type
      t.float :minimum_grade
      t.float :maximum_grande
      t.float :cancellation_percentage

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Cancellation config', object: 'CancellationConfig',default: true})
attributes = [{:name=>"record_type", :type=>:string}, {:name=>"fund", :type=>:references}, {:name=>"cancellation_type", :type=>:string}, {:name=>"minimum_grade", :type=>:float}, {:name=>"maximum_grande", :type=>:float}, {:name=>"cancellation_percentage", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'cancellation_configs'})
end

  end
end
