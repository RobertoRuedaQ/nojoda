class CreateStudentDebts < ActiveRecord::Migration[5.2]
  def change
    create_table :student_debts do |t|
      t.string :type_of_debt
      t.date :start_payment_date
      t.date :end_payment_date
      t.float :amount
      t.float :yearly_interest_rate
      t.string :what_did_you_ask_the_money_for
      t.string :payment_periodicity

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Student debt', object: 'StudentDebt',default: true})
attributes = [{:name=>"type_of_debt", :type=>:string}, {:name=>"start_payment_date", :type=>:date}, {:name=>"end_payment_date", :type=>:date}, {:name=>"amount", :type=>:float}, {:name=>"yearly_interest_rate", :type=>:float}, {:name=>"what_did_you_ask_the_money_for", :type=>:string}, {:name=>"payment_periodicity", :type=>:string}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'student_debts'})
end

  end
end
