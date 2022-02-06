class CreateBffQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :bff_questions do |t|
      t.string :status
      t.string :acacemic_year
      t.string :citizenship_status
      t.boolean :pre_approved
      t.boolean :applied_federal
      t.string :term_applying_for
      t.references :application
      t.boolean :authorized_to_work
      t.date :visa_expiration_date
      t.string :visa_case
      t.boolean :isa_to_pay_deposit
      t.boolean :scolarship_for_funded_program
      t.boolean :us_or_mexico_program

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Bff question', object: 'BffQuestion',default: true})
attributes = [{:name=>"status", :type=>:string}, {:name=>"acacemic_year", :type=>:string}, {:name=>"citizenship_status", :type=>:string}, {:name=>"pre_approved", :type=>:boolean}, {:name=>"applied_federal", :type=>:boolean}, {:name=>"term_applying_for", :type=>:string}, {:name=>"application", :type=>:reference}, {:name=>"authorized_to_work", :type=>:boolean}, {:name=>"visa_expiration_date", :type=>:date}, {:name=>"visa_case", :type=>:string}, {:name=>"isa_to_pay_deposit", :type=>:boolean}, {:name=>"scolarship_for_funded_program", :type=>:boolean}, {:name=>"us_or_mexico_program", :type=>:boolean}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'bff_questions'})
end

  end
end
