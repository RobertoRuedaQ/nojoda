module LumniGeneral

  def self.included(base)
    base.extend(LumniClassMethods)
  end

	module LumniBothMethods
	  include ApplicationHelper
	  include FormInfoHelper
	  include ListsHelper
	  include LumniApproval


	  def lumniSave params, current_user,config = {}
	  	company = config[:company_id].nil? ? nil : config[:company_id]
	  	className = self.class.to_s.downcase == 'class' ? self.name.downcase : self.class.to_s.downcase
	  	targetModel = config[:model].nil? ? className : config[:model].downcase
	  	config[:model] = targetModel

	  	puts "LumniSave params: #{params}"


	  	paramsKeys = params.keys - ['controller', 'action', 'id']
	  	case params[:action]
	  	when 'index'
	  		if current_user.allowed_view?(params) || current_user.allowed_create?(params)
	  			result = 'authorized'
	  		else
	  			result = 'unauthorized'
	  		end
	  	when 'new'
	  		if current_user.allowed_create?(params)
	  			result = 'authorized'
	  		else
	  			result = 'unauthorized'
	  		end
	  	when 'edit'
	  		if current_user.allowed_update?(params) || current_user.allowed_just_view?(params)
	  			result = 'authorized'
	  		else
	  			result = 'unauthorized'
	  		end
	  	when 'create'
	  		if current_user.allowed_create_with_approval?(params)
	  			request = current_user.request_for_create(self,reason: 'just because')
	  			if request.save
	  				supervisorUpdate = current_user.approval_requests.last
	  				supervisorUpdate.supervisor_id = current_user.approval_match.find_by_approver_role(params[:controller] + '_create_approver').approver_id
	  				supervisorUpdate.save
	  				result = 'approval_request'
	  			else
	  				result = 'failed'
	  			end

	  		elsif current_user.allowed_create?(params)

	  			puts 'esta es la info completa: ' + self.attributes.to_s
		 		if self.save
		 			result = 'created'
		 		else
		 			result = 'failed'
		 		end
		 	end
	 	when 'update'
	  		if current_user.allowed_update_with_approval?(params)
	  			partialParams = params[config[:model]]
	  			tempFilters = config[:list].nil? ? eval(params[:controller] + '_fields') : config[:list]
	  			filterParams = tempFilters.keys.map{|f| (tempFilters[f][:disabled].nil? || tempFilters[f][:disabled].nil?) ? f : nil}.compact
	  			targetUpdate = self.tap do |record| 
	  				filterParams.each do |f|
	  					record[f] = partialParams[f] if !partialParams[f].nil?
	  				end
	  			end
	  			request = current_user.request_for_update(targetUpdate,reason: 'just because')
	  			if request.save
	  				supervisorUpdate = current_user.approval_requests.last
	  				supervisorUpdate.supervisor_id = current_user.approval_match.find_by_approver_role(params[:controller] + '_update_approver').approver_id
	  				supervisorUpdate.save
 	  				result = 'approval_request'
	  			else
	  				result = 'failed'
	  			end

	  		else
	 			puts "setting_params(params,nil,config): #{setting_params(params,nil,config)}"
		 		if self.update_attributes(setting_params(params,nil,config))
		 			result = 'updated'
		 		else
		 			result = 'failed'
		 		end
		 	end
	 	when 'destroy'
	  		if current_user.allowed_destroy_with_approval?(params)
	  			request = current_user.request_for_destroy(self, reason: 'just because')
	  			if request.save
	  				supervisorUpdate = current_user.approval_requests.last
	  				supervisorUpdate.supervisor_id = current_user.approval_match.find_by_approver_role(params[:controller] + '_destroy_approver').approver_id
	  				supervisorUpdate.save
	  				result = 'approval_request'
	  			else
	  				result = 'failed'
	  			end
	  		else
		 		if self.discard
		 			result = 'discarded'
		 		else
		 			puts 'tienes permiso pero no me dio la gana'
		 			result = 'failed'
		 		end
		 	end
	 	end
	 	return result
	  end

		def setting_params params,company=nil,config = {}
			puts "current_params: #{params}"
			tempKeys = params.keys
			tempKeys = tempKeys - ['utf8','_method','authenticity_token']
			tempList = []

			puts "config[:list].nil?: #{config[:list].nil?}"

			begin
				puts "Entering the first setting"
				lumniList = config[:list].nil? ? eval(params[:controller] + '_fields') : config[:list]
			rescue
				puts "Entering the second setting"
				lumniList = config[:list].nil? ? eval("#{params[:controller]}_fields(company)")  : config[:list]
			end

			puts "lumniList: #{lumniList}"

			lumniList.keys.each_with_index do |l,index|
				puts "target_key: #{l}"
				puts "key_validation: #{lumniList[l].keys.include?(:disabled) || system_variables.include?(l.to_s)}"
			  unless lumniList[l].keys.include?(:disabled) || system_variables.include?(l.to_s)
			    tempList[index] = l
			  end      
			end

			targetRequire = config[:model].nil? ? tempKeys[0].to_sym : config[:model].to_sym
			puts "config: #{config}"
			puts "Keys: #{tempKeys}"
			puts "targetRequire: #{targetRequire}"
			puts "tempList: #{tempList}"
			tempList = tempList.compact

			attached_fields = eval("#{params[:controller].singularize.camelize}.all_active_storage_fields")
			multiple_fields = eval("#{params[:controller].singularize.camelize}.active_storage_fields_has_many")
			
			tempList.each do |temp_key|
				if (params[targetRequire.to_sym][temp_key] == '' || params[targetRequire.to_sym][temp_key] == [''] )&& attached_fields.include?(temp_key.to_s)
					params[targetRequire.to_sym] = params[targetRequire.to_sym].except(temp_key)
				elsif multiple_fields.include?(temp_key.to_s)

					# Parameters with hash should be at the end of the definition for not causing errors.
					tempList -= [temp_key]
					tempList += ["#{temp_key}: []"]
				elsif params[targetRequire.to_sym][temp_key].is_a?(Array)
					params[targetRequire.to_sym][temp_key] = params[targetRequire.to_sym][temp_key].join(';')
				end
			end

			text_permit = tempList.map{|element| (element.is_a? String) ? element : ":#{element}"}.join(',')
			finalParams = eval("params.require(targetRequire).permit(#{text_permit})")

			puts "finalParams: #{finalParams}"
			return finalParams
		end


	end

  
  module LumniClassMethods
		include LumniBothMethods

	  def lumniStart params,company,config = {}
	  	className = self.class.to_s.downcase == 'class' ? self.name.downcase : self.class.to_s.downcase
	  	targetModel = config[:model].nil? ? className : config[:model].downcase
	  	config[:model] = targetModel


	  	case params[:action]
	  	when 'new'
	  		puts 'self.attribute_names:' + self.attribute_names.to_s
	  		self.new()
	  	when 'index'
	  		begin
	  			self.cached_kept
	  		rescue
	  			nil
	  		end

	  	when 'edit'
	  		self.cached_find(params[:id])
	  	when 'update','destroy'
	  		self.cached_find(params[:id])
	  	when 'create'
	  		puts "setting_params(params,company,config): #{setting_params(params,company,config)}"
	  		self.new(setting_params(params,company,config))
	  	end
	  end

	  def lumni_association_list origin = nil
		association_list = self.reflect_on_all_associations(:has_one).collect {|a| {type: 'has',name: a.name,class_name: a.class_name,polymorphic: a.polymorphic?}}
		association_list += self.reflect_on_all_associations(:has_many).collect {|a| {type: 'has',name: a.name,class_name: a.class_name,polymorphic: a.polymorphic?}}
		association_list += self.reflect_on_all_associations(:belongs_to).collect {|a| {type: 'belongs',name: a.name,class_name: a.class_name,polymorphic: a.polymorphic?}}

		association_list = association_list.map{|a| a[:polymorphic] ? nil : a}.compact

		#exceptions
		

		exceptions = [:approval_items,:roles,:audits]
		association_list = association_list.map{|a| exceptions.index(a[:name]).nil? ? a : nil}.compact


		if !origin.nil?
			association_list = association_list.map{|a| (origin[:class_name] == self.to_s && origin[:type] == a[:type]) ? nil : a}.compact
			case origin[:type]
			when 'has'
				association_list = association_list.map{|a| (origin[:class_name] == self.to_s && a[:type] == 'belongs') ? nil : a}.compact
			when 'belongs'
				association_list = association_list.map{|a| (origin[:class_name] == self.to_s && a[:type] == 'has') ? nil : a}.compact
			end
		end
		return association_list
	  end

	  def get_lumni_association_list
	  	start_list = self.lumni_association_list
	  	include_list = start_list.map{|a| a[:name]}
	  	start_list.each do |element|
	  		include_list += recurrent_association_list element
	  	end
	  	return include_list
	  end

	  def recurrent_association_list origin
	  	start_list = eval(origin[:class_name]).lumni_association_list origin
	  	include_list = start_list
	  	include_list = [origin[:name] => start_list.map{|a| a[:name]}] if start_list.count > 0 
	  	start_list.each do |element|
	  		puts element[:name]
	  		include_list += recurrent_association_list element
	  	end
	  	return include_list
	  end

  end



	include LumniBothMethods


end
