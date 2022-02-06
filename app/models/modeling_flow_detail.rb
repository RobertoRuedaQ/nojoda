class ModelingFlowDetail < ApplicationRecord
      
	resourcify
	audited
	belongs_to :modeling_flow
	has_many :modeling_flow_extra, dependent: :destroy
	has_many :modeling_flow_fee, dependent: :destroy

	def fee
		self.modeling_flow_fee.map{|f| f.detail_fee}.inject(:+)
	end
end
