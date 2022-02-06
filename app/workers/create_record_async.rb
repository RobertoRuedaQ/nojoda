class CreateRecordAsync
	include Sidekiq::Worker
  sidekiq_options queue: 'default'
  
  def perform klass, attr = {}
    klass = klass.classify.constantize
    klass.create(attr)
	end
end
