class UpdateIncomeInformationStatusJob < ApplicationJob

  def perform(*args)

  	IncomeInformation.where(status: 'rejected').where(operations_status: nil).update_all(operations_status: 'rejected')
  	IncomeInformation.where.not(status: 'rejected').where('end_date < ?', Time.now).where(operations_status: nil).update_all(operations_status: 'finished')
  	IncomeInformation.where.not(status: 'rejected').where('end_date >= ?', Time.now).where(operations_status: nil).update_all(operations_status: 'active')
  	IncomeInformation.where.not(status: 'rejected').where(end_date: nil).where(operations_status: nil).update_all(operations_status: 'active')


  	IncomeInformation.where.not(status: 'rejected').where(status: 'rejected').where.not(operations_status: 'rejected').update_all(operations_status: 'rejected')
  	IncomeInformation.where.not(status: 'rejected').where('end_date < ?', Time.now).where.not(operations_status: 'finished').update_all(operations_status: 'finished')
  	IncomeInformation.where.not(status: 'rejected').where('end_date >= ?', Time.now).where.not(operations_status: 'active').update_all(operations_status: 'active')
  	IncomeInformation.where.not(status: 'rejected').where(end_date: nil).where.not(operations_status: 'active').update_all(operations_status: 'active')

    # Do something later
  end
end
