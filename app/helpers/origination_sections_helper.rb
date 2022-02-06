module OriginationSectionsHelper
	def createOriginationSections sectionId
		@origination_module = OriginationModule.cached_find(sectionId)
		render 'origination_sections/partial/sections'
	end
end
