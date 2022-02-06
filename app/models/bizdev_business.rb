class BizdevBusiness < ApplicationRecord
      
      resourcify
      audited
  belongs_to :leader, class_name: 'User', foreign_key: 'leader_id'
  belongs_to :coleader, class_name: 'User', foreign_key: 'coleader_id'
  belongs_to :original_idea, class_name: 'User', foreign_key: 'original_idea_id'
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'
  belongs_to :bizdev_business, optional: true
  has_many :childrens,->{kept}, class_name: 'BizdevBusiness', foreign_key: 'bizdev_business_id', dependent: :destroy
  has_many :bizdev_operation, dependent: :destroy

  has_one :project, as: :resource , dependent: :destroy

  after_create :create_project

  def create_project
  	newProject = Project.create({title: self.name, person_project: true,resource_type: 'BizdevBusiness', resource_id: self.id, owner_id: self.created_by_id})
  	setDefaults newProject.id
    target_leader = self.project.project_team.find_by_user_id(self.leader_id)
    target_coleader = self.project.project_team.find_by_user_id(self.coleader_id)
    ProjectTeam.create({project_id: newProject.id, user_id: self.leader_id }) if target_leader.nil?
    ProjectTeam.create({project_id: newProject.id, user_id: self.coleader_id }) if target_coleader.nil?
  end

  def setDefaults projectId
    defaultCards = ['on-hold','in-progress','under-review','done']
    defaultCards.each_with_index do |card, index|
      tempCard = ProjectCard.create({title: card,position: index,project_id: projectId})
    end
  end

  def self.visible user_id
    self.joins(:project,project: :project_team).where(projects: {project_teams: {user_id: user_id}})
  end


end
