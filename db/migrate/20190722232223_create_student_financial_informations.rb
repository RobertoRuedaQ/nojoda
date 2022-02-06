class CreateStudentFinancialInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :student_financial_informations do |t|
      t.float :total_personal_income
      t.string :who_pays_your_expenses
      t.string :what_is_your_income_source
      t.boolean :do_you_use_banking_service, default: false
      t.string :do_you_have_these_goods
      t.boolean :are_you_currently_working, default: false
      t.boolean :does_the_family_prioritize_activities, default: false
      t.string :family_support_frequency
      t.float :expenses_academic_activities
      t.string :other_financial_sources
      t.boolean :will_you_work_while_studying, default: false
      t.boolean :can_you_access_school_resources, default: false
      t.float :salary_after_5_years_of_graduation
      t.boolean :do_you_have_savings, default: false
      t.float :savings_value
      t.boolean :do_you_have_family_economical_support, default: false
      t.float :family_support_value
      t.float :debt_value
      t.references :user, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Student financial information', object: 'StudentFinancialInformation',default: true})
attributes = [{:name=>"total_personal_income", :type=>:float}, {:name=>"who_pays_your_expenses", :type=>:string}, {:name=>"what_is_your_income_source", :type=>:string}, {:name=>"do_you_use_banking_service", :type=>:boolean}, {:name=>"do_you_have_these_goods", :type=>:string}, {:name=>"are_you_currently_working", :type=>:boolean}, {:name=>"does_the_family_prioritize_activities", :type=>:boolean}, {:name=>"family_support_frequency", :type=>:string}, {:name=>"expenses_academic_activities", :type=>:float}, {:name=>"other_financial_sources", :type=>:string}, {:name=>"will_you_work_while_studying", :type=>:boolean}, {:name=>"can_you_access_school_resources", :type=>:boolean}, {:name=>"salary_after_5_years_of_graduation", :type=>:float}, {:name=>"do_you_have_savings", :type=>:boolean}, {:name=>"savings_value", :type=>:float}, {:name=>"do_you_have_family_economical_support", :type=>:boolean}, {:name=>"family_support_value", :type=>:float}, {:name=>"debt_value", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'student_financial_informations'})
end

  end
end
