class ProjectTaskTypeUser < ApplicationRecord
  resourcify
  audited
  belongs_to :user
  belongs_to :project_task_type
end
