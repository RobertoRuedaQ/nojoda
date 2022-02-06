class CreateBillingDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :billing_documents do |t|
      t.references :isa, foreign_key: true
      t.float :value
      t.string :status
      t.date :due_to_date
      t.float :payment_weight

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps
    end

    newTemplate = FormTemplate.create({name: 'Default Billing document', object: 'BillingDocument',default: true})
    attributes = [{:name=>"isa", :type=>:references}, {:name=>"status", :type=>:string}, {:name=>"due_date", :type=>:date}]
    attributes.each_with_index do |attribute,index|
      tempFormat = 'string'
      if !attribute[:type].nil?
        tempFormat = attribute[:type].to_s
      end
      FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
    end
    # Assigning the new template
    TeamProfile.kept.each_with_index do |profile, index|
      TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'billing_documents'})
    end
  end
end
