class ScaleHerokuDynosJob < ApplicationJob
  queue_as :worker
  
  def perform(*args)
    ScaleHerokuDynosService.call
  end
end
  
  