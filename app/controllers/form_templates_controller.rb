class FormTemplatesController < ApplicationController
	def index
		adjusting_templates
		@form_template = FormTemplate.lumniStart(params,current_company,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		contactFormTemplate = @form_template.lumniSave(params,current_user,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		lumniClose(@form_template,contactFormTemplate,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
	end

	def new
		@form_template = FormTemplate.lumniStart(params,current_company,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		contactFormTemplate = @form_template.lumniSave(params,current_user,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		lumniClose(@form_template,contactFormTemplate,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
	end

	def create
		@form_template = FormTemplate.lumniStart(params,current_company,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		contactFormTemplate = @form_template.lumniSave(params,current_user,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		lumniClose(@form_template,contactFormTemplate,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
	end

	def edit
		@form_template = FormTemplate.lumniStart(params,current_company,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		contactFormTemplate = @form_template.lumniSave(params,current_user,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		lumniClose(@form_template,contactFormTemplate,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))

		adjusting_fields(@form_template)


	end

	def update
		@form_template = FormTemplate.lumniStart(params,current_company,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		contactFormTemplate = @form_template.lumniSave(params,current_user,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		lumniClose(@form_template,contactFormTemplate,current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
	end
	def destroy
		@form_template = FormTemplate.lumniStart(params,current_company,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		contactFormTemplate = @form_template.lumniSave(params,current_user,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		lumniClose(@cluster,contactFormTemplate,current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
	end

	def clone_template
		params[:action] = 'edit'
		@form_template = FormTemplate.lumniStart(params,current_company,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		@form_template.name = nil
		contactFormTemplate = @form_template.lumniSave(params,current_user,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		lumniClose(@form_template,contactFormTemplate,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
	end

	def create_clone
		params[:action] = 'create'
		@form_template = FormTemplate.lumniStart(params,current_company,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))
		contactFormTemplate = @form_template.lumniSave(params,current_user,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))

		if !@form_template.id.nil?
			original_template = FormTemplate.cached_find(params[:id])
			original_template.form_field.each do |field|
				new_field = field.dup
				new_field.form_template_id = @form_template.id
				if new_field.save!
					field.form_attribute.each do |attrib|
						new_attribute = attrib.dup
						new_attribute.form_field_id = new_field.id
						new_attribute.save!
					end
				end
			end
		end

		lumniClose(@form_template,contactFormTemplate,list: current_user.template('FormTemplate','form_templates',current_user,current_company: current_company))

	end


	def sort
		FormField.update(params[:sort],(1..params[:sort].length).map{ |o |{order: o, row: params[:row].to_i}})
	end

	def field_form
		@form_field = FormField.find(params[:id])
	end

	def uniform_grid
		@form_template = FormTemplate.find(params[:id])
		@form_template.form_field.update_all(grid: params[:grid])
		adjusting_fields(@form_template)
	end

	
	private

	def adjusting_fields target_template
		current_fields = target_template.field_names
		all_fields = eval(target_template.object).attribute_names


		all_fields +=	eval(target_template.object).
								reflect_on_all_associations(:has_one).
								map { |reflection| reflection.name.to_s }.
								select { |name| name.match?(/_attachment/) }.
								map { |name| name.chomp('_attachment').to_s }


		all_fields +=	eval(target_template.object).
						  reflect_on_all_associations(:has_many).
						  map { |reflection| reflection.name.to_s }.
						  select { |name| name.match?(/_attachments/) }.
						  map { |name| name.chomp('_attachments').to_s }


		repeated_fields = current_fields.map{|f| f if current_fields.count(f) > 1 }.uniq.compact


		fields_to_remove = current_fields - all_fields
		fields_to_add = all_fields - current_fields



		# Important, the order might be remove, then add.
		fields_to_remove.each do |deprecated_field|
			target_template.form_field.find_by_name(deprecated_field).discard
		end

		fields_to_add.each do |new_field|
			FormField.create(name: new_field, status: 'inactive', form_template_id: target_template.id,grid: 12, row: 0)
		end

		repeated_fields.each do |repeated|
			target_template.form_field.where(name: repeated,row: 0).destroy_all
		end

		@field_attributes = target_template.cached_field_info(current_user,current_company)

	end

	def adjusting_templates
		templateSummary = FormTemplate.all.map{|t| t.object if t.default == true}.compact
		models_list.each do |model|
			if !templateSummary.include?(model)
				tempTemplate = FormTemplate.create({default: true, name: 'Default '+ model.underscore.humanize, object: model})
				adjusting_fields(tempTemplate)
			end
		end
	end


end