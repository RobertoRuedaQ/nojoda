module MultipleSelectionHelper

	def createMultipleSelection object, list,selected,formName,options={}

		@object = object
		@list = list
		@selected = selected
		@options = options
		@formName = formName

		render 'forms/multiple_selection'

	end

end