class CreateCancellationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :cancellation_requests do |t|
      t.float :term_gpa
      t.references :disbursement, foreign_key: true
      t.float :final_gpa
      t.string :term
      t.string :status
      t.references :application, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Cancellation request', object: 'CancellationRequest',default: true})
attributes = [{:name=>"term_gpa", :type=>:float}, {:name=>"disbursement", :type=>:references}, {:name=>"final_gpa", :type=>:float}, {:name=>"term", :type=>:string}, {:name=>"status", :type=>:string}, {:name=>"application", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'cancellation_requests'})
end

  end
end
