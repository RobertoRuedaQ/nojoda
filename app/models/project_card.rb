class ProjectCard < ApplicationRecord
  resourcify
  audited

  scope :force_cards,->(){where.not(id: nil)}
  scope :full_card, -> (user_id){includes(:main_tasks,main_tasks: :checklist, main_tasks: :project_comment,main_tasks: [checklist: :project_comment]).merge(ProjectTask.visible(user_id)).references(:main_tasks).merge(ProjectTask.visible(user_id)).references(main_tasks: :checklist)}

  belongs_to :project, touch: true
  has_many :project_task, -> { where(archived: false).order(position: :asc).kept },dependent: :destroy
  has_many :main_tasks, -> { where(archived: false).where(parent_id: nil).order(position: :asc).kept}, class_name: 'ProjectTask'
  has_many :archived_tasks, -> { where(archived: true).order(position: :asc).kept}, class_name: 'ProjectTask'


  after_commit :flush_full_card

  def cached_full_card user_id
  	Rails.cache.fetch([self.id,'cached_card']){get_full_card(user_id)}
  end

  def flush_full_card
    Rails.cache.delete([self.id,'cached_card'])
  end

  def get_full_card user_id
  	begin
  		result = ProjectCard.full_card(user_id).find(self.id)
  	rescue
  		result = self
  	end
  end
end
