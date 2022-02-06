class CreateValuationDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :valuation_details do |t|
      t.date :date
      t.float :student_flow
      t.float :fund_flow
      t.float :investor_flow
      t.float :fees
      t.references :valuation_history, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Valuation detail', object: 'ValuationDetail',default: true})
attributes = [{:name=>"date", :type=>:date}, {:name=>"student_flow", :type=>:float}, {:name=>"fund_flow", :type=>:float}, {:name=>"investor_flow", :type=>:float}, {:name=>"fees", :type=>:float}, {:name=>"valuation_history", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'valuation_details'})
end

  end
end
