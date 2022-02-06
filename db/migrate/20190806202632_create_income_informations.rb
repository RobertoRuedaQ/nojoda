class CreateIncomeInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :income_informations do |t|
      t.references :country, index: true
      t.references :city, index: true
      t.references :state, index: true
      t.string :company_name
      t.string :position
      t.string :contact_name
      t.string :contact_phone
      t.string :contract_case
      t.date :start_date
      t.float :fix_income
      t.string :contact_email
      t.string :sector
      t.date :end_date
      t.string :shift
      t.string :email_supervisor
      t.string :name_supervisor
      t.string :position_supervisor
      t.string :company_address
      t.string :company_phone
      t.float :variable_income
      t.string :company_identification
      t.references :user, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Income information', object: 'IncomeInformation',default: true})
attributes = [{:name=>"country", :type=>:references}, {:name=>"city", :type=>:references}, {:name=>"state", :type=>:references}, {:name=>"company_name", :type=>:string}, {:name=>"position", :type=>:string}, {:name=>"contact_name", :type=>:string}, {:name=>"contact_phone", :type=>:string}, {:name=>"contract_case", :type=>:string}, {:name=>"start_date", :type=>:date}, {:name=>"fix_income", :type=>:float}, {:name=>"contact_email", :type=>:string}, {:name=>"sector", :type=>:string}, {:name=>"end_date", :type=>:date}, {:name=>"shift", :type=>:string}, {:name=>"email_supervisor", :type=>:string}, {:name=>"name_supervisor", :type=>:string}, {:name=>"position_supervisor", :type=>:string}, {:name=>"company_address", :type=>:string}, {:name=>"company_phone", :type=>:string}, {:name=>"variable_income", :type=>:float}, {:name=>"company_identification", :type=>:string}, {:name=>"user", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'income_informations'})
end

  end
end
