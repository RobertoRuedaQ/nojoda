class RemoveInterviewTemplateTable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :interview_templates, if_exists: true
  end
end
