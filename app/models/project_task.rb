class ProjectTask < ApplicationRecord
  resourcify
  audited except: [:list_order,:position,:project_card_id]
  scope :by_responsable, -> (user_id){where(responsable_id: user_id).kept.undone}
  scope :by_creator, -> (user_id){where(created_by_id: user_id).kept}

  scope :main_task, -> (){ where(parent: nil).kept}
  scope :done, -> (){ where(done: true)}
  scope :undone, -> (){ where(done: false)}
  scope :expired, -> (user_id){ where(responsable_id: user_id).where("deadline < ?",Date.today).undone.kept}
  scope :upcoming, -> (user_id){ where(responsable_id: user_id).where("deadline >= ? AND deadline <= ? ",Date.today, Date.today + 2.days).undone.kept}
  scope :regular, -> (user_id){ where(responsable_id: user_id).where("deadline > ? ",Date.today + 2.days).undone.kept}
  scope :without_deadline, -> (user_id){ where(deadline: nil,responsable_id: user_id).undone.kept}
  scope :public_view, -> (){kept.where(archived: false, private: false)}
  scope :own_private, -> (user_id){kept.where(archived: false,private: true, created_by_id: user_id)}
  scope :assigned_private, -> (user_id){kept.where(archived: false, private: true, responsable_id: user_id)}
  scope :visible, -> (user_id) {public_view.or(own_private(user_id)).or(assigned_private(user_id))}
  scope :full_task, -> {includes(:responsable,:created_by,:project_task_type,:project_card,:parent,:resource,:checklist,:project_comment)}

  has_one_attached :task_support
  


  belongs_to :responsable, :class_name => 'User', foreign_key: 'responsable_id'
  belongs_to :created_by, :class_name => 'User', foreign_key: 'created_by_id', optional: true
  belongs_to :project_task_type
  belongs_to :project_card, touch: true
  belongs_to :parent, class_name: 'ProjectTask', foreign_key: 'parent_id', optional: true, touch: true
  belongs_to :resource, polymorphic: true, optional: true
  has_many :checklist, -> { order(:position).kept }, class_name: 'ProjectTask', foreign_key: 'parent_id'
  has_many :project_comment, -> { order(created_at: :desc).kept }, dependent: :destroy

  before_update :discard_dependents

  before_create :check_new

  after_commit :flush_task

  after_create :task_notification

  def self.create_system_task support_role_name, target_student, task_type_title, resource = {}
    task_type = ProjectTaskType.find_by_title(task_type_title)
    if !task_type.nil?
      support_role = SupportRole.find_by_role_case(support_role_name)
      target_support = target_student.support_person(support_role.id).supervisor
      ProjectTask.create!({deadline: Time.now.to_date + support_role.response_in_days.days,created_by_id: target_support.id, responsable_id: target_support.id,
        project_task_type_id: task_type.id,project_card_id: target_student.own_project.project_card.first.id,position: 1, company_id: target_student.company_id,
        progress: 0,start_date: Time.now.to_date,locked: true,resource: resource[:record]})
    end
  end


  def cached_comment_count
    Rails.cache.fetch(['cached_comment_count',self.id],expires_in: 8.hours){project_comment.count}
  end

  def task_notification
    if self.created_by_id != self.responsable_id
      Notification.create({notification_case_id: 1, resource_type: 'ProjectTask',resource_id: self.id,user_id: self.responsable_id})
    end
  end

  def responsable_name
    Rails.cache.fetch(['responsable_name',self.id]){responsable.name}
  end

  def created_by_name
    Rails.cache.fetch(['created_by_name',self.id]){created_by.name}
  end

  def self.id_groups target_ids
    target_ids = target_ids.values.flatten.uniq.sort if target_ids.is_a? Hash
    Rails.cache.fetch(['project_task_group_ids',target_ids.join(',')],expires_in: 8.hours){where(id: target_ids).to_a}
  end



  def flush_task
    Rails.cache.delete(['checklist_count',self.id])
    Rails.cache.delete(['responsable_name',self.id])
    Rails.cache.delete(['created_by_name',self.id])
    Rails.cache.fetch(['project_task.cached_card_title',self.id])
  end

  def checklist_count
    self.checklist.kept.count 
  end

  def cached_checklist_count
    Rails.cache.fetch(['checklist_count',self.id],expires_in: 8.hours){checklist_count}
  end

  def check_new
    if self.responsable_id != self.created_by_id
      self.read_check = false
    end
  end 

  def target_title language
    projectType = ProjectTaskType.cached_find(self.project_task_type_id)
    if projectType.title == 'custom'
      target_title = self.title
    else
      target_title = projectType.target_name language
    end
  end

  def target_description language
    projectType = ProjectTaskType.cached_find(self.project_task_type_id)
    if projectType.title == 'custom'
      target_title = self.description
    else
      target_title = projectType.target_description language
    end
  end

  def project_title
    self.project_card.project.title
  end

  def project_id
    Rails.cache.fetch(['project_task.project_id',self.id],expires_in: 8.hours){project_card.project_id}
  end

  def cached_card_title
    Rails.cache.fetch(['project_task.cached_card_title',self.id],expires_in: 8.hours){project_card.title}
  end

  def cached_project_title
    Rails.cache.fetch(['cached_project_title',self.project_id],expires_in: 8.hours){project_title}
  end

  def project_id
    self.project_card.project_id
  end

  def project
    self.project_card.project
  end

  def main_task_name
    if !self.parent.nil?
      self.parent.title
    end
  end

  def phash
    self.attributes.to_s
  end

  def discard_dependents
    if self.discarded? 
      self.checklist.cached_update_all({discarded_at: Time.now})
    end
  end

  def done_card
    ProjectCard.where(title: 'done',project_id: self.project_id).first
  end

  def make_it_done
    self.done = true
    self.done_date = Time.now.to_date
    self.progress = 100
    self.project_card_id = self.done_card.id
    self.save
  end

  def make_all_done
    result = false
    if self.make_it_done
      result = self.checklist.cached_update_all({done: true, done_date: Time.now.to_date,progress: 100,project_card_id: self.done_card.id})
    end
    return result
  end

end
