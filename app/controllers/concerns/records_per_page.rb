module RecordsPerPage
  extend ActiveSupport::Concern

  private

 	def records_per_page
		return 25 if params[:per_page].nil?

		params[:per_page]
	end
end