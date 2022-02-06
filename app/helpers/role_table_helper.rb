module RoleTableHelper
	include LumniDataStructureInformation
	def createRoleTable(targetRecord,controller,action,id,options={})
		Rails.cache.clear
		@targetRecord = targetRecord
		@controller = controller
		@id = id
		@action = action
		@options = options
		@currentRoles = targetRecord.cached_role_names
		@mainActions = ['create','update','destroy']
		@actions = ['regular','with_approval','supervisor']

		@allActions = []

		@mainActions.each do | action|
			@allActions += @actions.map{|a| action + '_' + a}
		end

		@allActions = ['module_permission','view'] + @allActions 



		@models = models_list
		controllers = controllers_list
		@role_names = []
		@permissions = ['view','create','create_with_approval','create_approver','update','update_with_approval','update_approver','destroy','destroy_with_approval','destroy_approver']

		controllers.each_with_index do |controller,index|
			@role_names[index] = @permissions.map{|p| controller + '_' + p}
		end

		@hash_approver = @targetRecord.approvers_hash

		@role_names
		render 'forms/role_table'
	end

	def lumni_role_boolean_field object,f,options,config={}
		status = {type: 'checkbox', class: 'switcher-input',value: options[:roles].include?(f), name: 'roles' + '_' + f + '_',
		 id: 'roles' + '_' + f  + 'frontcheck',disabled: options[:disabled], required: options[:required], hidden: options[:hidden],
		 oninvalid: "setErrroMessage(this,'#{options[:error_text]}','#{options[:type]}')",oninput: "removeErrorMessage(this,'#{options[:type]}')"}

		if options[:roles].include?(f)
			status[:checked] = true
		end

		content_tag(:div,nil, class: 'col-12') +
		content_tag(:input,nil,value: options[:roles].include?(f),hidden: true, name: 'roles' + '[' + f + ']',id: 'roles' + '_' + f )+
		content_tag(:label,class: 'switcher') do 
			concat content_tag(:input, nil,  status )
			concat content_tag(:span,
				content_tag(:span, content_tag(:span,nil,class: 'ion ion-md-checkmark') , class: 'switcher-yes') + 
				content_tag(:span, content_tag(:span,nil,class: 'ion ion-md-close'), class: 'switcher-no'),
				class: 'switcher-indicator')
			concat content_tag(:span,nil,class: 'switcher-label')
			concat content_tag(:label, I18n.t(options[:boolean_text]),class: 'form-label')
		end
	end










end