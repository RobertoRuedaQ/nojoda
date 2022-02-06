class Migration < ApplicationRecord
  resourcify
  audited
  include LumniMigration

  has_many :migration_field,->{order(:id)}, dependent: :destroy
  belongs_to :parent, class_name: 'Migration', foreign_key: 'migration_id',optional: true
  has_many :children, class_name: 'Migration',foreign_key: 'migration_id', dependent: :destroy
  has_many :migrations_backup, dependent: :destroy
  has_many :migration_job, dependent: :destroy

  after_commit :set_model_fields
  after_commit :migrate_process

  def self.pending_tracking
    MigrationJob.last.migration_tracking.where(status: 'regular', processed_records: 0).count
  end

  def self.find_record_in_tracking target_id
    MigrationTracking.where("backup like ?", "%#{target_id}%")
  end
  

  def self.migration_restart
    MigrationJob.last.migration_tracking.where(status: 'regular').last.start_processing_data
  end

  def self.reset_job
    #MigrationAsync.perform_async('restart_target_job',12633)
    restart_target_job MigrationJob.last.id
  end 

  def self.migration_order
    # [31,32,33,2,30,34,3,35,36,37,38,9,103,10,96,19,20,21,22,23,24,25,26,27,29,28,39,102,40,42,41,43,44,45,46,47,50,48,49,52,53,55,56,57,105,106,58,59,60,61]
    [31,32,33,2,30,34,3,35,36,37,38,9,103,10,19,20,21,22,23,24,25,26,27,29,28,102,39,40,42,41,43,44,45,46,47,50,48,49,52,53,55,56,57,105,106,58,59,60,61,107,109,108,113,110,111,117,118,112,114,115,116,117,118,121,122,119,123,124,125,126,127,128]
  end

  def self.advance_level
    [MigrationJob.last.migration_tracking.where(status: 'regular').sum(:processed_records), MigrationJob.last.target_record_number.to_i]
  end

  def self.current_job_array
    migration = MigrationJob.last.migration
    [migration.id,migration.name]
  end

  def self.last_job_key
    MigrationJob.last.external_id
  end

  def self.last_migration_jobs
    MigrationJob.where(external_id: Migration.last_job_key)
  end

  def set_model_fields
		target_fields = eval(self.rails_object).attribute_names - ['id','external_id','discarded_at','migrated','created_at','updated_at','encrypted_password','reset_password_token',
      'reset_password_sent_at','remember_created_at','sign_in_count','current_sign_in_at','last_sign_in_at','current_sign_in_ip','last_sign_in_ip',
      'confirmation_token','confirmed_at','confirmation_sent_at','unconfirmed_email','failed_attempts','unlock_token','locked_at',
      'type']
		current_fields = self.migration_field.map{|m| m.model_field}

		fields_to_add = target_fields - current_fields
		fields_to_remove = current_fields - target_fields

		fields_to_add.each do |field|
			MigrationField.create({model_field: field, migration_id: self.id})
		end

		fields_to_remove.each do |field|
			self.migration_field.find_by_model_field(field).destroy
		end
  end

  def migrate_process

  	if !['migrate','force_migration'].index(self.status).nil?
  		target_ids = [self.id]
  		while !Migration.find(target_ids.first).migration_id.nil?
  			target_ids = [Migration.find(target_ids.first).migration_id] + target_ids
  		end

  		Migration.where(id: target_ids).update_all({ notes: "Running! Triggered by the migration '#{self.name} (#{self.id})' #{Time.now}"})

      if Rails.env == 'production'
        MigrationAsync.perform_async('main_migration_method',target_ids)
      else
        main_migration_method(target_ids)
      end
      
  	end

  end



end
