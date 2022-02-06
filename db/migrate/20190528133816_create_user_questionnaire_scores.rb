class CreateUserQuestionnaireScores < ActiveRecord::Migration[5.2]
  def change
    create_table :user_questionnaire_scores do |t|
      t.references :user_questionnaire, foreign_key: true
      t.references :questionnaire, foreign_key: true
      t.float :score

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end

newTemplate = FormTemplate.create({name: 'Default User questionnaire score', object: 'UserQuestionnaireScore',default: true})
attributes = [{:name=>"user_questionnaire", :type=>:references}, {:name=>"questionaire", :type=>:references}, {:name=>"score", :type=>:float}]
attributes.each_with_index do |attribute,index|
  tempFormat = 'string'
  if !attribute[:type].nil?
    tempFormat = attribute[:type].to_s
  end
  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
end
# Assigning the new template
TeamProfile.kept.each_with_index do |profile, index|
  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'user_questionnaire_scores'})
end

  end
end
