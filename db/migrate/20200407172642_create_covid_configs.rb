class CreateCovidConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :covid_configs do |t|
      t.references :fund, foreign_key: true
      t.boolean :normal
      t.boolean :due_date
      t.boolean :payment_agreement
      t.boolean :custom_adjustment
      t.boolean :no_payment

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Covid config', object: 'CovidConfig',default: true})
attributes = [{:name=>"fund", :type=>:references}, {:name=>"normal", :type=>:boolean}, {:name=>"due_date", :type=>:boolean}, {:name=>"payment_agreement", :type=>:boolean}, {:name=>"custom_adjustment", :type=>:boolean}, {:name=>"no_payment", :type=>:boolean}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'covid_configs'})
end

  end
end
