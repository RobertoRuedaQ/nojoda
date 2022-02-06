class UpdateAsync
	include Sidekiq::Worker

	sidekiq_options queue: 'heavy_work'

  def perform(klass, id, params={})
    klass.classify.constantize.find(id).update(params)
  end

end