module PaymentBatchesHelper

	def payment_batch_index_target_index_fields
		['id','fund_name','month','year','status']
	end

	def translate_batch_index_fields field, batch
		case field
		when 'id'
			result = link_to batch.id, edit_payment_batch_path(batch), class: 'text-primary'
		when 'month'
			result = lumni_month batch.send(field)
		else
			result = batch.send(field)
		end
		return result
	end

	def payment_batch_index_table_header
		payment_batch_index_target_index_fields.map{|f| PaymentBatch.human_attribute_name(f)}
	end

	def payment_batch_index_table_rows batches
		result = []
		batches.each do |batch|
			result += [payment_batch_index_target_index_fields.map{|f| translate_batch_index_fields( f, batch)}]
		end
		return result
	end
end
