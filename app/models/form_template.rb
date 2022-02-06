class FormTemplate < ApplicationRecord
      
      resourcify
      audited
      belongs_to :child, class_name: 'FormTemplate', foreign_key: 'child_id', optional: true
      has_many :form_field, -> { order(:row,:order) }, dependent: :destroy
      has_many :team_profile_template, dependent: :destroy
      has_many :origination_section, as: :resource

      after_commit :flush_cached_field_info

      def field_rows
      	self.form_field.kept.map{|f| f.row}.compact.uniq
      end

      def fields_by_row row 
            self.form_field.kept.where(row: row)
      end

      def fields_and_rows
      	fieldHash = {}
      	self.form_field.kept.each do |field|
      		fieldHash[field.row] = (fieldHash[field.row].nil? ? [] : fieldHash[field.row]) + [field.order]
      	end

      	return fieldHash
      end

      def names_and_rows
            fieldHash = {}
            self.form_field.kept.each do |field|
                  fieldHash[field.row] = (fieldHash[field.row].nil? ? [] : fieldHash[field.row]) + [field.name]
            end

            return fieldHash
      end

      def fields_info current_user, current_company
            cached_hash_by_row( current_user,current_company, [0,1])
      end

      def cached_field_info current_user, current_company
            Rails.cache.fetch([self.id, 'fields_info']){fields_info(current_user,current_company)}
      end

      def cached_template_hash current_user,current_company
            Rails.cache.fetch([self.id,'template_hash']){template_hash current_user,current_company}
      end

      def template_hash current_user,current_company
            hash_by_row( current_user,current_company, 1)
      end

      def hash_by_row current_user,current_company, rows
            total_fields = {}
            list_fields = self.form_field.includes(:form_attribute).where(row: rows).kept.to_a
            list_fields.each do |field|
                  total_fields[field.name.to_sym] = field.cached_field_options(current_user,current_company,self)
            end
            return total_fields
      end

      def cached_hash_by_row current_user,current_company, rows
            Rails.cache.fetch(['cached_hash_by_row',self.id,'u',current_user.id,'r',rows]){hash_by_row( current_user,current_company, rows)}
      end





      def flush_cached_field_info
            Rails.cache.clear
            # Rails.cache.delete([self.id, 'fields_info'])
            # Rails.cache.delete([self.id, 'cached_object'])
            # Rails.cache.delete(['listProfileTemplateByModel',self.object])
      end

      def field_names
            self.form_field.kept.map{|f| f.name}
      end


end

