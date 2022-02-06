class CreateSociodemographics < ActiveRecord::Migration[5.2]
  def change
    create_table :sociodemographics do |t|
      t.references :user, foreign_key: true
      t.references :state, index: true
      t.references :city, index: true
      t.references :country, index: true
      t.string :house_type
      t.string :health_coverage
      t.string :ethnicity
      t.integer :health_ranking
      t.string :neighborhood
      t.integer :strata
      t.string :indigenous_community
      t.boolean :disabilities
      t.integer :children_number
      t.integer :siblings_number
      t.integer :siblings_position
      t.string :people_living_together
      t.string :other_people_living_together
      t.string :main_financial_support_person
      t.integer :dependent_number
      t.string :family_living_together
      t.string :other_family_living_together
      t.boolean :mother_alive
      t.boolean :father_alive
      t.boolean :living_with_parents

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default Sociodemographic', object: 'Sociodemographic',default: true})
attributes = [{:name=>"state", :type=>:references}, {:name=>"city", :type=>:references}, {:name=>"country", :type=>:references}, {:name=>"house_type", :type=>:string}, {:name=>"health_coverage", :type=>:string}, {:name=>"ethnicity", :type=>:string}, {:name=>"health_ranking", :type=>:integer}, {:name=>"neighborhood", :type=>:string}, {:name=>"strata", :type=>:integer}, {:name=>"indigenous_community", :type=>:string}, {:name=>"disabilities", :type=>:boolean}, {:name=>"children_number", :type=>:integer}, {:name=>"siblings_number", :type=>:integer}, {:name=>"siblings_position", :type=>:integer}, {:name=>"people_living_together", :type=>:string}, {:name=>"other_people_living_together", :type=>:string}, {:name=>"main_financial_support_person", :type=>:string}, {:name=>"dependent_number", :type=>:integer}, {:name=>"family_living_together", :type=>:string}, {:name=>"other_family_living_together", :type=>:string}, {:name=>"mother_alive", :type=>:boolean}, {:name=>"father_alive", :type=>:boolean}, {:name=>"living_with_parents", :type=>:boolean}, {:name=>"user_id", :type=>:references}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'sociodemographics'})
end



  end
end
