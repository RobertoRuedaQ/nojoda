module FormTemplatesHelper
	def createFieldTemplate row,options = {}
		@row = row
		@options = options

		render 'form_templates/partial/field_body'


	end

	def createFieldAttributeDetail attribute_id
		@attribute = FormAttribute.cached_find(attribute_id)
		render 'form_fields/partial/attribute_detail'
	end
end
