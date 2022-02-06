class CreateWompiTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :wompi_transactions do |t|
      t.string :payment_method
      t.float :value
      t.float :tax
      t.float :base
      t.references :billing_document, foreign_key: true
      t.references :mercado_pago_gateway, foreign_key: true
      t.string :status
      t.string :ip_address
      
      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps
    end

    newTemplate = FormTemplate.create({name: 'Default Wompi transaction', object: 'WompiTransaction',default: true})
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
      TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'wompi_transactions'})
    end
  end
end
