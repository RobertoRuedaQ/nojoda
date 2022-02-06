class ModelingFlowFee < ApplicationRecord
      
      resourcify
      audited
  belongs_to :modeling_fee
  belongs_to :modeling_flow_detail
end
