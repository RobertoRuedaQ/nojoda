class ProjectTaskTranslate < ApplicationRecord
      
  resourcify
  audited
  belongs_to :project_task_type
end
