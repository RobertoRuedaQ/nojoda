module LumniApi
	def lumni_api verb, path, params, config = {}
		new_api = ApiHistory.new({verb: verb, url: path, params: params.to_s, 
			user_id: config[:user_id],context: config[:context], status: 'sent'})
		if new_api.save
			begin
				start_request = Time.now
				answer = eval("RestClient.#{verb} path, params")
				answer.force_encoding('UTF-8')
				result = JSON.parse(answer.body)
				new_api.response_time = (Time.now - start_request).to_f
				puts "(Time.now - start_request).to_f: #{(Time.now - start_request).to_f}"
				new_api.response = result
				new_api.status = 'done'
				new_api.save
			rescue Exception => e
				new_api.response = e.message
				new_api.status = 'error'
				new_api.response_time = (Time.now - start_request).to_f
				new_api.save
			end
		else
			new_api = nil
		end
		return new_api
	end

	def research_api action, params
		lumni_api 'post',"http://research.lumniportal.net/#{action}",params
	end

	def api_collection_params target_collection
		result = {}
		target_collection.each do |element|
			result["dataframe_#{element.class}-#{element.id}"] = element.attributes
		end
		return result
	end



	
end