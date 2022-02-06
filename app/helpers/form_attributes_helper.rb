module FormAttributesHelper

	def changeFormAttributeValueField target_format, options = {}

		target_filter = form_attributes_fields
		target_filter[:value][:field_type] = target_format
		case target_format
		when 'list'
			target_filter[:value][:list] = list_of_lists
		when 'legal_language'
			target_format = 'list'
			target_filter[:value][:list] = generalLegalLanguageHelperList
		when 'boolean'
			target_filter[:value][:value] = false
		end



		if options[:attribute_id].nil?
			object = FormAttribute.new()
		else
			object = FormAttribute.cached_find(options[:attribute_id])
		end

		lumni_field_selector( object,'value',target_filter)
	end
end
