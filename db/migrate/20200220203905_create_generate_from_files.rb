class CreateGenerateFromFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :generate_from_files do |t|
      t.references :resource, polymorphic: true, index: true
      t.string :target_object
      t.string :status
      t.string :notes
      t.string :process

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Generate from file', object: 'GenerateFromFile',default: true})
attributes = [{:name=>"resource", :type=>:references}, {:name=>"target_object", :type=>:string}, {:name=>"status", :type=>:string}, {:name=>"notes", :type=>:string}, {:name=>"process", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'generate_from_files'})
end

  end
end
