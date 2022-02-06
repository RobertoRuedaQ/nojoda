class CreateBankAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_accounts do |t|
      t.string :account_case
      t.string :bank_name
      t.integer :account_number
      t.string :bank_certification
      t.date :certification_date
      t.string :status
      t.boolean :active
      t.boolean :main
      t.string :url_token
      t.references :resource, polymorphic: true, index: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Bank account', object: 'BankAccount',default: true})
attributes = [{:name=>"account_case", :type=>:string}, {:name=>"bank_name", :type=>:string}, {:name=>"account_number", :type=>:integer}, {:name=>"bank_certification", :type=>:string}, {:name=>"certification_date", :type=>:date}, {:name=>"status", :type=>:string}, {:name=>"active", :type=>:boolean}, {:name=>"main", :type=>:boolean}, {:name=>"url_token", :type=>:string}, {:name=>"resource", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'bank_accounts'})
end

  end
end
