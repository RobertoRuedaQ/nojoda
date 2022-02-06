module BasicTableHelper

	def createBasicTable(headers,rows_info,options={})
		@headers = headers
		@rows_info = rows_info
		@options = options

		render 'forms/basic_table'
	end
end