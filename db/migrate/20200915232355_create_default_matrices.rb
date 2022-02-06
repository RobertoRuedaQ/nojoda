class CreateDefaultMatrices < ActiveRecord::Migration[5.2]
  def change
    create_table :default_matrices do |t|
      t.references :country, foreign_key: true
      t.string :fund_case
      t.float :probability
      t.integer :number

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Default matrix', object: 'DefaultMatrix',default: true})
attributes = [{:name=>"country", :type=>:references}, {:name=>"fund_case", :type=>:string}, {:name=>"probability", :type=>:float}, {:name=>"number", :type=>:integer}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'default_matrices'})
end

  end
end
