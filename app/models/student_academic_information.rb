class StudentAcademicInformation < ApplicationRecord
      
  resourcify
  audited

  belongs_to :user, touch: true
  belongs_to :institution, optional: true
  belongs_to :major,->{kept}, optional: true
  belongs_to :city, class_name: 'Geography', foreign_key: 'city_id', optional: true
  belongs_to :state, class_name: 'Geography', foreign_key: 'state_id', optional: true
  belongs_to :country, class_name: 'Geography', foreign_key: 'country_id', optional: true
  belongs_to :application, optional: true, touch: true
  has_one :school_info,dependent: :destroy
  has_one :university_info, dependent: :destroy
  has_many :academic_request, dependent: :destroy
  has_many :disbursement

  has_many :isa
  has_many :academic_stop,-> {kept}, dependent: :destroy
  has_many :past_applications,->{where.not(status: ['active','submitted'])} ,as: :resource, class_name: 'Application' , dependent: :destroy
  has_one :origination_application,->{where(status: ['active','submitted'])} , as: :resource, class_name: 'Application' , dependent: :destroy
  has_many :university_grade, dependent: :destroy
  has_one :school_grade, dependent: :destroy
  has_one_attached :graduation_certificate
  has_one_attached :diploma
  has_one_attached :standardized_state_test_certificate
  has_one_attached :grades_certificate
  has_one_attached :grades_certificate_school
  has_one_attached :pensum
  has_one_attached :tuition_certificate
  has_one_attached :all_grades_certificate
  has_one_attached :admission_certificate
  
  before_commit :align_drop_out_date
  after_commit :update_academic_status
  after_commit :flush_academic_cache

  def funding_opportunity
    self.application.funding_opportunity
  end

  def fund
    self.funding_opportunity.fund
  end

  def company
    self.fund.company
  end

  def country
    self.company.country
  end

  def modeling_clusters
    cluster_hash = {}
    self.potential_not_approved_version.major.cluster.each do |cluster|
      cluster_hash[cluster.cluster_case] = cluster.value
    end
    if !self.potential_not_approved_version.application.nil? && !self.potential_not_approved_version.application.funding_opportunity.nil? && !self.potential_not_approved_version.application.funding_opportunity.fund.nil?
      cluster_hash['CF0'] = self.potential_not_approved_version.application.funding_opportunity.fund.external_id
    end

    if !self.potential_not_approved_version.institution.nil?
      cluster_hash['CDE'] = self.potential_not_approved_version.institution.state_internal_code
      cluster_hash['CCI'] = self.potential_not_approved_version.institution.city_internal_code
    end
      cluster_hash['country_code'] = self.potential_not_approved_version.country.international_code
    return cluster_hash
  end

  def update_academic_status
    if self.academic_status != self.stored_academic_information
      self.update(stored_academic_information: self.academic_status)
    end
  end

  def academic_status
    if self.in_academic_stop?
      result = 'academic_stop'
    elsif self.drop_out?
      result = 'drop_out'
    elsif graduation_process?
      result = 'graduation_process'
    elsif graduated?
      result = 'graduated'
    else
      result = 'studing'
    end
    return result
  end

  def graduated?
    !self.graduation_date.nil? && self.graduation_date <= Time.now.to_date
  end

  def graduation_process?
    if self.egress_date.nil?
      result = false
    elsif self.egress_date <= Time.now.to_date
      if !self.graduated?
        result = true
      else
        result = false
      end
    else
      result = false
    end
    return result
  end

  def drop_out?
    !self.drop_out_date.nil?
  end

  def in_academic_stop?
    self.cached_active_academic_stop.count > 0
  end

  def all_academic_stop
    self.academic_stop.where(status: 'active')
  end

  def active_academic_stop
    self.academic_stop.where(status: 'active').where('start_date <= ?', Time.now.to_date).where('end_date >= ?',Time.now.to_date)
  end

  def cached_active_academic_stop
    Rails.cache.fetch(['cached_active_academic_stop',self.id]){active_academic_stop}
  end

  def flush_academic_cache
    Rails.cache.delete(['cached_active_academic_stop',self.id])
  end

  def align_drop_out_date
    if self.drop_out_date.nil? && self.drop_out == true
      self.drop_out_date = Time.now.to_date
    elsif !self.drop_out_date.nil? && self.drop_out == false
      self.drop_out_date = nil
    end
  end

  def origination
    self.user.company.origination_funded_major
  end

  def level_and_term
    [self.major.academic_level.to_s, self.current_term.to_s].join('-')
  end

  def final_institution
    if self.institution_id.nil?
      result = self.other_institution_text
    else
      result = self.institution.name
    end
    return result
  end

  def final_major
    if self.major_id.nil?
      result = self.other_program_text
    else
      result = self.major.name
    end
    return result
  end
end