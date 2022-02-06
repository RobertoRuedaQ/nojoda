class ModelingMainSencibility < ApplicationRecord
      
      resourcify
      audited

      has_many :modeling_sencibilities, dependent: :destroy


  def execute_first_analisys target_funding_opportunity_ids
  	# SencibilityAnalisysAsync.perform_async(1,[224, 225, 226, 227, 228, 229, 230, 231, 232, 234, 235, 236, 237, 238, 239])

  	# target_funding_opportunity_ids = [224, 225, 226, 227, 228, 229, 230, 231, 232, 234, 235, 236, 237, 238, 239]
		funding_options = FundingOption.joins(:application).where(applications: {resource_type: 'FundingOpportunity', resource_id: target_funding_opportunity_ids, status: 'submitted', discarded_at: nil}).kept
		funding_options.each do |funding_option|
			begin


				info_hash = funding_option.info_hash_for_r
				original_default = info_hash['modeling_variables'].select{|info| info[:acronym] == 'default'}.first['value']
				original_unemployment = info_hash['modeling_variables'].select{|info| info[:acronym] == 'desempleo'}.first['value']
				dropout_keys = info_hash['modeling_variables'].map{|info| info[:acronym]}.select{|acronym| acronym.include?('desercion_periodo')}
				original_dropout = {}
				dropout_keys.each do |drop_key|
					original_dropout[drop_key] = info_hash['modeling_variables'].select{|info| info[:acronym] == drop_key}.first['value']
				end

				self.modeling_sencibilities.each do |sencibility|
					info_hash['modeling_variables'].select{|info| info[:acronym] == 'default'}.first['value'] = original_default.to_f + sencibility.delta_default 
					info_hash['modeling_variables'].select{|info| info[:acronym] == 'desempleo'}.first['value'] = original_unemployment.to_f + sencibility.delta_unemployment
					delta_dropout = sencibility.delta_dropout.to_f / dropout_keys.size

					dropout_keys.each do |drop_key|
						info_hash['modeling_variables'].select{|info| info[:acronym] == drop_key}.first['value'] = original_dropout[drop_key] + delta_dropout
					end
					modeling_info = funding_option.target_research_process.run_research_process info_hash

					target_detail = sencibility.modeling_sencibility_details.find_by(funding_option_id: funding_option.id)
					if target_detail.nil?
						target_detail  = ModelingSencibilityDetail.create({ modeling_sencibility_id: sencibility.id, 
																																funding_option_id: funding_option.id, 
																																term: modeling_info["funding_option"].first["isa_term"], 
																																study_percentage: modeling_info["funding_option"].first["percentage_student"], 
																																graduated_percentage:modeling_info["funding_option"].first["percentage_graduated"], 
																																status: 'done', 
																																total_disbursement: modeling_info["disbursement"].map{|disbursement| disbursement["student_value"]}.inject(:+), 
																																log_info: modeling_info.to_s})
					else
						target_detail  = ModelingSencibilityDetail.update({ modeling_sencibility_id: sencibility.id, 
																																funding_option_id: funding_option.id, 
																																term: modeling_info["funding_option"].first["isa_term"], 
																																study_percentage: modeling_info["funding_option"].first["percentage_student"], 
																																graduated_percentage:modeling_info["funding_option"].first["percentage_graduated"], 
																																status: 'done', 
																																total_disbursement: modeling_info["disbursement"].map{|disbursement| disbursement["student_value"]}.inject(:+), 
																																log_info: modeling_info.to_s})
					end

				end

				
			rescue Exception => e
				
			end

  	end
  end





end
