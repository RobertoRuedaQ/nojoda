module LumniCsv
	require 'csv'

	def return_csv object, fields, headers=true
		CSV.generate(headers: headers) do |csv|
			csv << fields
			object.each do |row|
				csv << fields.map{|f| get_nested_value(row,f)}
			end
		end
	end


	def get_nested_value row, f
		fields = f.to_s.split('.')
		value_text = (['row'] + fields.map{|field| "send('#{field}')"}).join('.')
		begin
			result = eval(value_text)
		rescue Exception => e
			result = nil
		end
		return result
	end

end