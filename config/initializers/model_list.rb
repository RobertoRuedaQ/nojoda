class ModelList

  def self.get
    models_list
  end
  
  private

  def self.models_list
    files = Dir[Rails.root + 'app/models/*.rb']
    models = files.map do |m| 
      model_name = File.basename(m, '.rb').camelize
      model_name.constantize < ApplicationRecord ? model_name : nil
    end
    @list ||= models.compact
  end
end