class CreateModelingFees < ActiveRecord::Migration[5.2]
  def change
    create_table :modeling_fees do |t|
      t.string :fees
      t.string :fee_name
      t.string :fee_case
      t.string :r_type_fixed
      t.integer :fee_peridicity
      t.boolean :fee_included_taxes
      t.boolean :fee_inflation_adjustment
      t.float :fee_iva
      t.string :fee_who_pay
      t.string :fee_target
      t.float :fee_fixed_part
      t.float :fee_variable_part
      t.boolean :fee_cp
      t.boolean :fee_rp
      t.float :percentaje_fee_cp
      t.float :percentaje_fee_rp
      t.date :value_fee_start_fee_field
      t.date :value_fee_end_fee_field
      t.float :value_fee_unique_date_field
      t.float :value_fee_variable_part_field
      t.float :fee_fixed_adjustment
      t.float :fee_another_tax
      t.references :modeling, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Modeling fee', object: 'ModelingFee',default: true})
attributes = [{:name=>"fees", :type=>:string}, {:name=>"fee_name", :type=>:string}, {:name=>"fee_case", :type=>:string}, {:name=>"r_type_fixed", :type=>:string}, {:name=>"fee_peridicity", :type=>:integer}, {:name=>"fee_included_taxes", :type=>:boolean}, {:name=>"fee_inflation_adjustment", :type=>:boolean}, {:name=>"fee_iva", :type=>:float}, {:name=>"fee_who_pay", :type=>:string}, {:name=>"fee_target", :type=>:string}, {:name=>"fee_fixed_part", :type=>:float}, {:name=>"fee_variable_part", :type=>:float}, {:name=>"fee_cp", :type=>:boolean}, {:name=>"fee_rp", :type=>:boolean}, {:name=>"percentaje_fee_cp", :type=>:float}, {:name=>"percentaje_fee_rp", :type=>:float}, {:name=>"value_fee_start_fee_field", :type=>:date}, {:name=>"value_fee_end_fee_field", :type=>:date}, {:name=>"value_fee_unique_date_field", :type=>:float}, {:name=>"value_fee_variable_part_field", :type=>:float}, {:name=>"fee_fixed_adjustment", :type=>:float}, {:name=>"fee_another_tax", :type=>:float}, {:name=>"modeling", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'modeling_fees'})
end

  end
end
