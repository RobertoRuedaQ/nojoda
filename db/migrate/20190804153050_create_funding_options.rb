class CreateFundingOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :funding_options do |t|
      t.float :percentage_student
      t.float :percentage_graduated
      t.integer :isa_term
      t.date :offer_due_date
      t.date :cancelation_due_date
      t.date :acceptance_date
      t.boolean :visible_to_student

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Funding option', object: 'FundingOption',default: true})
attributes = [{:name=>"percentage_student", :type=>:float}, {:name=>"percentage_graduated", :type=>:float}, {:name=>"isa_term", :type=>:integer}, {:name=>"offer_due_date", :type=>:date}, {:name=>"cancelation_due_date", :type=>:date}, {:name=>"acceptance_date", :type=>:date}, {:name=>"visible_to_student", :type=>:boolean}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'funding_options'})
end

  end
end
