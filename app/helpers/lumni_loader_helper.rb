module LumniLoaderHelper
	def putLoader size
		@size = size
		render 'forms/lumni_loader'
	end
end
