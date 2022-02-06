class CreateMentoryEmpleabilityInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :mentory_empleability_invitations do |t|
      t.boolean :accept_invitation, default: false
      t.boolean :empleability, default: false
      t.boolean :mentory, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end

  newTemplate = FormTemplate.create({name: 'Default Mentory Empleability Invitation', object: 'MentoryEmpleabilityInvitation',default: true})
  attributes = [{:name=>"accept_invitation", :type=>:boolean}, {:name=>"user", :type=>:references}, {:name=>"empleability", :type=>:boolean}, {:name=>"mentory", :type=>:boolean}]
  attributes.each_with_index do |attribute,index|
    tempFormat = 'string'
    if !attribute[:type].nil?
      tempFormat = attribute[:type].to_s
    end
    FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})
  end

  TeamProfile.kept.each_with_index do |profile, index|
    TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'cancellation_configs'})
  end

end
