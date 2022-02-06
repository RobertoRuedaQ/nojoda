module MigrationsBackupsHelper
	def migration_backup_rows migration_id
		target_migration = Migration.cached_find(migration_id)
		migration_backup = MigrationsBackup.select('id,updated_at,user_id').where(migration_id: migration_id).to_a

		rows = migration_backup.map{|r| [link_to(lumni_date(r.updated_at),show_backup_migrations_backup_path(r),class: 'text-primary',remote: true,method: :post,data: { disable_with: I18n.t('form.please_wait')}),r.user.name]}
		return rows
	end

	def create_migration_backup_body backup_id
		@target_backup = MigrationsBackup.cached_find(backup_id)
		target_array = eval(@target_backup.backup)
		@header = target_array.first.keys
		@rows = target_array.map{|v| v.values}
		render 'migrations_backups/partial/backup_body'
	end


end
