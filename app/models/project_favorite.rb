class ProjectFavorite < ApplicationRecord
      
  resourcify
  belongs_to :project,touch: true
  belongs_to :user

  after_commit :flush_favorite

  def flush_favorite
  	Rails.cache.delete(['project_favorite',self.project_id,self.user_id])
  end
end
