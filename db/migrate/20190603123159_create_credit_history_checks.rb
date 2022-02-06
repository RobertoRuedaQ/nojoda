class CreateCreditHistoryChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_history_checks do |t|
      t.string :check_result
      t.float :funding_capacity
      t.float :indebtedness_level
      t.float :credit_score
      t.float :financial_duties
      t.references :user, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Credit history check', object: 'CreditHistoryCheck',default: true})
attributes = [{:name=>"check_result", :type=>:string}, {:name=>"funding_capacity", :type=>:float}, {:name=>"indebtedness_level", :type=>:float}, {:name=>"credit_score", :type=>:float}, {:name=>"financial_duties", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'credit_history_checks'})
end

  end
end
