class ProjectComment < ApplicationRecord
  resourcify
  belongs_to :project_task, touch: true
  belongs_to :user

  after_create :flush_comments

  def flush_comments
  	Rails.cache.delete(['cached_comment_count',self.project_task_id])
  end
end
