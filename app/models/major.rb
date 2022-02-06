class Major < ApplicationRecord
  resourcify
  audited

  belongs_to :institution, touch: true
  has_many :cluster, dependent: :destroy

  def lumni_level
    self.cluster.where(cluster_case: 'lumni_level').first
  end

  def lumni_area
    self.cluster.where(cluster_case: 'lumni_family').first
  end
  def lumni_core
    self.cluster.where(cluster_case: 'lumni_core').first
  end

  def self.cached_major_group institution_id, list_number
  	Rails.cache.fetch(['cached_major_group',institution_id,list_number]){Major.target_majors(institution_id, list_number)}
  end

  def self.target_majors institution_id, list_number
    selected_majors = nil
    if !list_number.nil? && list_number != ''
      selected_majors = FormList.cached_find(list_number.to_i).form_list_value.kept.pluck(:value)
    end
    
    if selected_majors.nil?
      result = Major.where(institution_id: institution_id).kept.order(:name).to_a
    else
      result = Major.where(institution_id: institution_id,id: selected_majors).kept.order(:name).to_a
    end   
    return result 

  end

end
