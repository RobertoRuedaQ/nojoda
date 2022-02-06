class CreateApplicants < ActiveRecord::Migration[5.2]
  def change

    newTemplate = FormTemplate.create({name: 'Default Applicant', object: 'Applicant',default: true})
    # Assigning the new template
    TeamProfile.kept.each_with_index do |profile, index|
      TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: 'applicants'})
    end

  end
end
