class CreateWompiResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :wompi_responses do |t|
      t.string :merchant_order_id
      t.string :status
      t.string :collection_id
      t.string :payment_id
      t.string :external_id
      t.string :payment_type
      t.string :preference_id
      t.string :site_id
      t.string :processing_mode
      t.string :merchant_account_id
      t.references :wompi_transaction, foreign_key: true
      t.string :authorization_code
      t.string :currency_id
      t.string :date_approved
      t.string :payment_method
      t.string :transaction_amount

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps
    end

    newTemplate = FormTemplate.create({name: 'Default Wompi response', object: 'WompiResponse',default: true})
    attributes = []
    attributes.each_with_index do |attribute,index|
      tempFormat = 'string'
      if !attribute[:type].nil?
        tempFormat = attribute[:type].to_s
      end
      FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
    end
    # Assigning the new template
    TeamProfile.kept.each_with_index do |profile, index|
      TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'wompi_responses'})
    end
  end
end
