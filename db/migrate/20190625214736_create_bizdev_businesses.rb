class CreateBizdevBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :bizdev_businesses do |t|
      t.string :name
      t.string :country
      t.string :priority
      t.references :leader, index: true
      t.references :coleader, index: true
      t.date :expected_closing_date
      t.string :phase
      t.float :expected_revenue
      t.float :expected_expenses
      t.float :expected_margin
      t.float :expected_cf
      t.string :expected_risk

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Bizdev business', object: 'BizdevBusiness',default: true})
attributes = [{:name=>"name", :type=>:string}, {:name=>"country", :type=>:string}, {:name=>"priority", :type=>:string}, {:name=>"leader", :type=>:refrences}, {:name=>"coleader", :type=>:references}, {:name=>"expected_closing_date", :type=>:date}, {:name=>"phase", :type=>:string}, {:name=>"expected_revenue", :type=>:float}, {:name=>"expected_expenses", :type=>:float}, {:name=>"expected_margin", :type=>:float}, {:name=>"expected_cf", :type=>:float}, {:name=>"expected_risk", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'bizdev_businesses'})
end

  end
end
