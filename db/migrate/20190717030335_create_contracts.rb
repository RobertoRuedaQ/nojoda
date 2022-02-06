class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.references :user, foreign_key: true
      t.integer :terms
      t.float :graduated_percentage
      t.float :studying_percentage
      t.float :nominal_payment
      t.references :application, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Contract', object: 'Contract',default: true})
attributes = [{:name=>"user", :type=>:references}, {:name=>"terms", :type=>:integer}, {:name=>"graduated_percentage", :type=>:float}, {:name=>"studying_percentage", :type=>:float}, {:name=>"nominal_payment", :type=>:float}, {:name=>"application", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'contracts'})
end

  end
end
