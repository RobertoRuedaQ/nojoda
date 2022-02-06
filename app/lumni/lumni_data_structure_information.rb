module LumniDataStructureInformation
  def controllers_list
    controllerList = Rails.application.routes.routes.map do |route|
      (!route.defaults[:controller].nil? && !route.defaults[:controller].include?('/')) ? route.defaults[:controller] : nil
    end.uniq.compact
  end

  def models_list
    ModelList.get
  end

  def find_controller_by_model model
    tempModel = model.underscore
    indexController = controllers_list.index(model.underscore)
    indexController = controllers_list.index(model.pluralize.underscore) if indexController.nil?
    result = controllers_list[indexController] if !indexController.nil?
    if result.nil?
      puts 'este es el modelo: ' + model.to_s
    end      
    result = model.pluralize.underscore if result.nil?
    return result
  end
end
