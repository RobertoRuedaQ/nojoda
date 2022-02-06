class AddModelingFlowDetailToModelingFlowExtra < ActiveRecord::Migration[5.2]
  def change
  	add_reference :modeling_flow_extras, :modeling_flow_detail, foreign_key: true
  	add_reference :modeling_flow_fees, :modeling_flow_detail, foreign_key: true
  	remove_reference :modeling_flow_extras, :modeling_flow, foreign_key: true
  	remove_reference :modeling_flow_fees, :modeling_flow, foreign_key: true
  end
end
