class CreateApplicationCommittees < ActiveRecord::Migration[5.2]
  def change
    create_table :application_committees do |t|
      t.references :invest_committee, foreign_key: true
      t.references :application, foreign_key: true
      t.string :status
      t.text :notes

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Application committee', object: 'ApplicationCommittee',default: true})
attributes = [{:name=>"invest_committee", :type=>:references}, {:name=>"application", :type=>:references}, {:name=>"status", :type=>:string}, {:name=>"notes", :type=>:text}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'application_committees'})
end

  end
end
