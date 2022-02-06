class CreatePaymentMasses < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_masses do |t|
      t.string :status
      t.text :notes
      t.references :company, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Payment mass', object: 'PaymentMass',default: true})
attributes = [{:name=>"status", :type=>:string}, {:name=>"notes", :type=>:text}, {:name=>"company", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'payment_masses'})
end

  end
end
