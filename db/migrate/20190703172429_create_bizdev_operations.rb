class CreateBizdevOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :bizdev_operations do |t|
      t.string :name
      t.string :phase
      t.date :start_date
      t.date :expected_end_date
      t.references :leader, index: true
      t.references :coleader, index: true
      t.references :bizdev_business, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Bizdev operations', object: 'BizdevOperation',default: true})
attributes = [{:name=>"name", :type=>:string}, {:name=>"phase", :type=>:string}, {:name=>"start_date", :type=>:date}, {:name=>"expected_end_date", :type=>:date}, {:name=>"leader", :type=>:references}, {:name=>"coleader", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'bizdev_operations'})
end

  end
end
