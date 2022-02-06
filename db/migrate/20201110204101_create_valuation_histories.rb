class CreateValuationHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :valuation_histories do |t|
      t.date :date
      t.references :user, foreign_key: true
      t.integer :expected_records
      t.string :status
      t.references :fund, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Valuation history', object: 'ValuationHistory',default: true})
attributes = [{:name=>"date", :type=>:date}, {:name=>"user", :type=>:references}, {:name=>"expected_records", :type=>:integer}, {:name=>"status", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'valuation_histories'})
end

  end
end
