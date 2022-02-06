class CreateMigrationAccumulations < ActiveRecord::Migration[5.2]
  def change
    create_table :migration_accumulations do |t|
      t.references :resource, polymorphic: true, index: true
      t.string :external_id
      t.string :name

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Migration accumulation', object: 'MigrationAccumulation',default: true})
attributes = [{:name=>"resource", :type=>:references}, {:name=>"external_id", :type=>:string}, {:name=>"name", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'migration_accumulations'})
end

  end
end
