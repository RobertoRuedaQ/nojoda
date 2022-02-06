class ModelingSencibility < ApplicationRecord
      
  resourcify
  audited

  belongs_to :modeling_main_sencibility
  has_many :modeling_sencibility_details, dependent: :destroy


  def self.create_first_analysis
		delta_default_levels = [0,0.01,0.03,0.05]
		delta_dropout_levels = [0,0.1,0.3,0.5]
		delta_unemployment_levels = [0,0.05,0.1,0.15]

		delta_default_levels.each do |default|
			delta_dropout_levels.each do |dropout|
				delta_unemployment_levels.each do |unemployment|
					ModelingSencibility.create({delta_default: default, delta_unemployment: unemployment, delta_dropout: dropout})			
				end
			end
		end
  end



end
