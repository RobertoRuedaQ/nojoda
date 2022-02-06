class Project < ApplicationRecord
  resourcify
  audited
  scope :staff_projects, -> (){where(person_project: false)}
  scope :active_projects, -> (user_id) {kept.on_progress.joins(:project_team).where(project_teams: {user_id: user_id},person_project: false)}
  scope :archived_projects, -> (user_id) {kept.where(archive: true).joins(:project_team).where(project_teams: {user_id: user_id},person_project: false)}
  scope :archive_nil, -> (){where(archive: nil)}
  scope :archive_false, -> (){where(archive: false)}
  scope :on_progress, -> (){archive_nil.or(archive_false)}
  scope :favorites, -> (user_id){joins(:project_favorite).where(project_favorites: {user_id: user_id})}
  scope :full_project, -> (user_id){includes(:project_card).merge(ProjectCard.full_card(user_id)).references(:project_card)}


  belongs_to :owner, :class_name => 'User', foreign_key: 'owner_id'
  belongs_to :resource, polymorphic: true, optional: true
  has_many :project_card, -> { order(position: :asc).kept }, dependent: :destroy
  has_many :project_team, dependent: :destroy
  has_many :project_favorite, dependent: :destroy

  after_create :createTeam

  after_commit :flush_project_task

  def flush_project_task
    Rails.cache.delete(['cached_all_tasks',self.id])
    Rails.cache.delete(['cached_project_title',self.id])
    Rails.cache.delete(['project.all_main_tasks',self.id])    
  end

  def createTeam
  	ProjectTeam.create({user_id: self.owner.id, project_id: self.id})
  end

  def set_favorite user_id
    target_favorite = self.project_favorite.find_by_user_id(user_id)
    if target_favorite.nil?
      ProjectFavorite.create({user_id: user_id, project_id: self.id})
    end
  end

  def remove_favorite user_id
    target_favorite = self.project_favorite.find_by_user_id(user_id)
    unless target_favorite.nil?
      target_favorite.destroy
    end
  end

  def cached_favorite user_id
    Rails.cache.fetch(['project_favorite',self.id,user_id]){favorite user_id}
  end

  def favorite user_id
    result = true
    if self.project_favorite.find_by_user_id(user_id).nil?
      result = false
    end
    return result
  end

  def access_granted user_id
    result = true
    if self.project_team.find_by_user_id(user_id).nil?
      result = false
    end
    return result
  end

  def all_tasks user_id
    card_ids = self.project_card.ids
    tasks = ProjectTask.includes(:project_card,:project_comment,:created_by,:responsable).where(project_card_id: card_ids).visible(user_id)
    return tasks
  end

  def all_main_tasks user_id
    card_ids = self.project_card.ids
    tasks = ProjectTask.where(project_card_id: card_ids,parent_id: nil).visible(user_id)
    return tasks
  end

  def cached_all_tasks user_id
    Rails.cache.fetch(['cached_all_tasks',self.id],expires_in: 8.hours){all_tasks(user_id)}
  end

  def cached_all_main_tasks user_id
    Rails.cache.fetch(['project.all_main_tasks',self.id],expires_in: 8.hours){all_main_tasks(user_id)}
  end



end
