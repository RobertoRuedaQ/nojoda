module BizdevBusinessesHelper

	def create_business_body business_id
		@target_business = BizdevBusiness.cached_find(business_id)
		render 'bizdev_businesses/partial/business_body'
	end

	def create_business_progress_bar business_id
		@target_business = BizdevBusiness.cached_find(business_id)
		render 'bizdev_businesses/partial/progress_bar'
	end

	def create_business_editor business_id
		@target_business = BizdevBusiness.cached_find(business_id)
		render 'bizdev_businesses/partial/editor_body'
	end

	def create_business_index_rows
		rows = @bizdev_business.map{|b| [(link_to b.name,edit_bizdev_business_path(b)),loadingAvatar( 20, id: b.leader_id),loadingAvatar( 20, id: b.coleader_id),
			search_value_in_a_list( b.country, countriesList),search_value_in_a_list( b.phase, bizDev_phases),
			search_value_in_a_list(b.general_status,business_general_status),search_value_in_a_list(b.priority,priority_list),
			b.expected_closing_date,b.expected_revenue,b.expected_cf,b.expected_risk]}
		return rows
	end

end
