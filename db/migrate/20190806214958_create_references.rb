class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :references do |t|
      t.string :first_name
      t.references :country, index: true
      t.string :middle_name
      t.string :last_name
      t.string :indentification_case
      t.date :birthday
      t.string :phone
      t.string :mobile
      t.string :address_1
      t.references :city, index: true
      t.references :state, index: true
      t.string :relationship
      t.string :other_relationship
      t.string :identification_number
      t.integer :unemployment_months
      t.string :reference_email
      t.string :labor_situation
      t.string :education_level
      t.boolean :guardian
      t.string :company
      t.string :occupation
      t.string :work_address
      t.string :work_phone
      t.string :marital_status
      t.float :total_income
      t.boolean :jointly_liable
      t.string :address_2
      t.string :zip_code
      t.references :user, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Reference', object: 'Reference',default: true})
attributes = [{:name=>"first_name", :type=>:string}, {:name=>"country", :type=>:references}, {:name=>"middle_name", :type=>:string}, {:name=>"last_name", :type=>:string}, {:name=>"indentification_case", :type=>:string}, {:name=>"birthday", :type=>:date}, {:name=>"phone", :type=>:string}, {:name=>"mobile", :type=>:string}, {:name=>"address_1", :type=>:string}, {:name=>"city", :type=>:references}, {:name=>"state", :type=>:references}, {:name=>"relationship", :type=>:string}, {:name=>"other_relationship", :type=>:string}, {:name=>"identification_number", :type=>:string}, {:name=>"unemployment_months", :type=>:integer}, {:name=>"reference_email", :type=>:string}, {:name=>"labor_situation", :type=>:string}, {:name=>"education_level", :type=>:string}, {:name=>"guardian", :type=>:boolean}, {:name=>"company", :type=>:string}, {:name=>"occupation", :type=>:string}, {:name=>"work_address", :type=>:string}, {:name=>"work_phone", :type=>:string}, {:name=>"marital_status", :type=>:string}, {:name=>"total_income", :type=>:float}, {:name=>"jointly_liable", :type=>:boolean}, {:name=>"address_2", :type=>:string}, {:name=>"zip_code", :type=>:string}, {:name=>"user", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'references'})
end

  end
end
