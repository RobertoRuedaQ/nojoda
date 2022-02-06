class FormListsController < ApplicationController
	def index
		@form_list = FormList.lumniStart(params,current_company,list: current_user.template('FormList','form_lists',current_user))
		contactFormList = @form_list.lumniSave(params,current_user, list: current_user.template('FormList','form_lists',current_user))
		lumniClose(@form_list,contactFormList)
	end

	def new
		@form_list = FormList.lumniStart(params,current_company,list: current_user.template('FormList','form_lists',current_user))
		contactFormList = @form_list.lumniSave(params,current_user, list: current_user.template('FormList','form_lists',current_user))
		lumniClose(@form_list,contactFormList)
	end

	def create
		@form_list = FormList.lumniStart(params,current_company,list: current_user.template('FormList','form_lists',current_user))
		contactFormList = @form_list.lumniSave(params,current_user, list: current_user.template('FormList','form_lists',current_user))
		lumniClose(@form_list,contactFormList)
	end

	def edit
		@form_list = FormList.lumniStart(params,current_company,list: current_user.template('FormList','form_lists',current_user))
		contactFormList = @form_list.lumniSave(params,current_user, list: current_user.template('FormList','form_lists',current_user))
		lumniClose(@form_list,contactFormList)
		@form_list_labels = languageList[:language][:labels]
		@form_list_values = languageList[:language][:values]

		# Functionality List
		options = ListsHelper.instance_methods
		list = {}
		list[:functionality] = {values: options, labels: options}
		@functionality_list = list

		# Value of the main selector
		if !@form_list.form_list_db.nil?
			@mainDropDownValue = 'functionality'
			@functionalityValue = @form_list.form_list_db.functionality
			params[:functionality] = @functionalityValue
			params[:form_list] = @form_list.id

			translate_functionality

		elsif @form_list.form_list_value.count > 0 
			@mainDropDownValue = 'values'
		else
			@mainDropDownValue = ''
		end

	end

	def update
		@form_list = FormList.lumniStart(params,current_company,list: current_user.template('FormList','form_lists',current_user))
		contactFormList = @form_list.lumniSave(params,current_user, list: current_user.template('FormList','form_lists',current_user))
		lumniClose(@form_list,contactFormList)
	end
	def destroy
		@form_list = FormList.lumniStart(params,current_company,list: current_user.template('FormList','form_lists',current_user))
		contactFormList = @form_list.lumniSave(params,current_user, list: current_user.template('FormList','form_lists',current_user))
		lumniClose(@cluster,contactFormList)
	end

	def evaluate_functionality functionality,current_user, current_company

		list = {}
		begin
			list = eval(functionality)
		rescue 
			begin
			list = eval(functionality + '(current_user)')
			rescue
				begin
					list = eval(functionality + '(current_company)')
				rescue 
					list = eval(functionality + '(current_user,current_company)')
				end
			end
		end
		return list
	end


	def translate_functionality 
		start_table
		functionality = params[:functionality]


		if functionality != ''

      functionality_inputs = method(functionality.to_sym).parameters.map{|f| f.last.to_s}
      extra_params = functionality_inputs - ['current_user','current_company']
      target_params = functionality_inputs - extra_params
      list = eval(functionality + "(#{target_params.join(',')})")
      


			groups = list.keys
			groups_translation = groups.map{ |g| I18n.t('list.' + g.to_s)}


			groups.each_with_index do |group, g_index|
				tempRow = [groups_translation[g_index]]
				targetValues = list[group][:values]
				translation_labels = {}
				@language.each do |lan|
					I18n.locale = lan
					translation_labels[lan] = eval(functionality + "(#{target_params.join(',')})")[group][:labels]
				end


				targetValues.each_with_index do | value, v_index|
					finalRow = tempRow
					finalRow += [value]
					@language.each do |lan |
						finalRow += [translation_labels[lan][v_index]]
					end
					@table_body += [finalRow]
				end
			end
			I18n.locale = current_user.language

			if @form_list.form_list_db.nil?
				FormListDb.create({form_list_id: @form_list.id, functionality: functionality})
			else
				@form_list.form_list_db.functionality = functionality
				@form_list.form_list_db.save
			end
		else
			if !@form_list.form_list_db.nil?
				@form_list.form_list_db.destroy
			end
		end


	end


	def form_functionality
		respond_to do |format|
			format.js
		end
	end

	def form_values
		@form_list = FormList.cached_find(params[:form_list])
		respond_to do |format|
			format.js
		end
	end

	def start_table
		@language = languageList[:language][:values]
		labels = [I18n.t('list.group'),I18n.t('list.values')] + languageList[:language][:labels]

		@header = labels
		@table_body = []
		@form_list = FormList.cached_find(params[:form_list])
	end

	def clone
		origin = FormList.cached_find(params[:id])
		params[:action] = 'create'
		@form_list = FormList.lumniStart(params,current_company,list: current_user.template('FormList','form_lists',current_user))
		contactFormList = @form_list.lumniSave(params,current_user, list: current_user.template('FormList','form_lists',current_user))

		list_db = origin.form_list_db
		if !list_db.nil?
			tempdb = list_db.dup
			tempdb.form_list_id = @form_list.id
			tempdb.save
		end

		origin.form_list_value.each do |list_value|
			tempvalue = list_value.dup
			tempvalue.form_list_id = @form_list.id
			if tempvalue.save
				puts 'entrando a salvar labels'
				list_value.form_label.each do |label|
					temp_label = label.dup
					temp_label.resource_type = "FormListValue"
					temp_label.resource_id = tempvalue.id
					temp_label.save
				end
			end
		end

		lumniClose(@form_list,contactFormList)

	end

	def new_clone
		@form_list = FormList.new
	end
end