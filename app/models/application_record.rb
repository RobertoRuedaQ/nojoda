class ApplicationRecord < ActiveRecord::Base
  include Discard::Model
  include LumniGeneral
  include LumniDataStructureInformation
  require 'csv'
  include LumniFinance
  
	acts_as_approval_resource
	after_commit :flush_commit_cache

  # Status for approval request object
  # state: { pending: 0, cancelled: 1, approved: 2, rejected: 3, executed: 4 }
  has_many :requested_changes, ->{order(:id)}, as: :resource,class_name: 'Approval::Item', dependent: :destroy
  has_many :pending_changes, ->{joins(:request).where(approval_requests: {state: 0}).order(:id)}, as: :resource,class_name: 'Approval::Item', dependent: :destroy
  has_many :pending_requests, ->{joins(:request).where(approval_requests: {state: 0}).order(:id)}, as: :resource,class_name: 'Approval::Item', dependent: :destroy
  has_many :pending_items, ->{joins(:request).where(approval_requests: {state: 0}).order(:id)}, class_name: 'Approval::Item', as: :resource

   devise :database_authenticatable, :recoverable, :rememberable


   def hash_to_clone target_id
    self.attributes.except("id", "external_id", "discarded_at", "migrated", "created_at", "updated_at", target_id)
   end

 def check
    # check
  end

  def current_send field
    self.potential_not_approved_version
    self.send(field)
  end

  def application_record_aproval_translate
    approval_hash = {}
    self.pending_items.each do |target_change|
      approval_hash = approval_hash.merge(target_change.params)
    end
    return approval_hash
  end

  def potential_not_approved_version
    self.attributes = self.application_record_aproval_translate
    self
  end




  def restore_detroyed_record target_id
    restored_info = Audited::Audit.where(auditable_id: target_id, auditable_type: self.model_name.to_s,action: "destroy").last.audited_changes
    #continue..
  end


  def cached_modules_and_sections
    Rails.cache.fetch(['cached_origination_by',self.model_name.to_s,self.origination.id]){modules_and_sections.to_a}
  end

  def modules_and_sections
    OriginationModule.includes(:origination_section, :application_module_track).where(origination_id: self.origination.id).kept.order(:order)
  end

  def cached_sections module_id
    Rails.cache.fetch(['cached_sections_',self.model_name.to_s,self.origination.id,module_id]){sections.to_a}
  end

  def sections module_id
    OriginationSection.where(origination_module_id: module_id).kept.order(:order)
  end

  def origination_template_by_target_model target_model, user, company
    OriginationSection.joins(:form_template, :origination_module).where(form_templates: {object: target_model}).where(origination_modules: {origination_id: self.origination.id,option: "form"}).kept.order(:order).first.cached_form_template.template_hash( user, company)
#    OriginationModule.joins(origination_section: :form_template).where(origination_sections: {form_templates: {object: target_model}}).where(origination_id: self.origination.id,option: "form").kept.order(:order).first
  end




   def pending_changes?
    self.pending_changes.count > 0
   end

   def self.full_field_names
    self.attribute_names + self.all_active_storage_fields
   end

   def self.all_active_storage_fields
    self.active_storage_fields_has_one + self.active_storage_fields_has_many
   end

   def self.active_storage_fields_has_one
    begin
      self.
          reflect_on_all_associations(:has_one).
          map { |reflection| reflection.name.to_s }.
          select { |name| name.match?(/_attachment/) }.
          map { |name| name.chomp('_attachment').to_s }      
    rescue Exception => e
      []
    end
   end

   def self.active_storage_fields_has_many
    begin
      self.
          reflect_on_all_associations(:has_many).
          map { |reflection| reflection.name.to_s }.
          select { |name| name.match?(/_attachment/) }.
          map { |name| name.chomp('_attachments').to_s }
    rescue Exception => e
      []
    end
   end


         
  def authenticatable_salt
    "#{super}#{session_token}"
  end

  def invalidate_all_sessions!
    self.update_attribute(:session_token, SecureRandom.hex)
  end

  def self.cached_update_all params= {}
    target_ids = self.ids
    target_model = self.model_name.to_s
    self.update_all(params)
    target_ids.each do |record|
      Rails.cache.delete([target_model,record])
    end
  end

  def self.cached_destroy_all
    target_ids = self.ids
    target_model = self.model_name.to_s
    self.destroy_all
    target_ids.each do |removed|
      Rails.cache.delete([target_model,removed])
    end
  end

	def self.cached_kept
		Rails.cache.fetch([name,'kept']) {kept}
	end

	def self.cached_find(id)
    return if id.nil?
    
		Rails.cache.fetch([name,id],expires_in: 8.days){includes(:pending_changes).find(id)}
	end

	def flush_commit_cache
		Rails.cache.delete([self.class.name,id])
	end

  def self.to_csv
    attributes = self.attribute_names
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |record|
        csv << attributes.map{ |attr| record.send(attr) }
      end
    end
  end
	

  self.abstract_class = true
end
