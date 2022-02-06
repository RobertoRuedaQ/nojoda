module IsaStatusesHelper
	# ['finalized_payments', 'out_of_the_fund','permanent_default','default','recovered_from_default','expelled','retired', 'ceded']
	def isa_status_general_status_actions isa
		result = []
		case isa.active_status( 'general_status').first
		when 'active', 'manual_activation'
			result = ['finalized_payments','out_of_the_fund','default','expelled','retired', 'ceded']
		when 'finalized_payments'
			result = ['ceded']
		when  'out_of_the_fund'
			result = ['ceded']
		when 'permanent_default'
			result = []
		when 'default'
			result = ['recovered_from_default','permanent_default','ceded']
		when 'recovered_from_default'
			result = ['finalized_payments','out_of_the_fund','permanent_default','expelled','retired', 'ceded']
		when 'expelled'
			result = ['finalized_payments','out_of_the_fund','default','retired','ceded']
		when 'retired'
			result = ['finalized_payments','out_of_the_fund','default','expelled','ceded']
		when  'ceded'
			result = []
		end
		return result		
	end
end
