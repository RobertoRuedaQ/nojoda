
class LumniGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

  def create_helper
  	tempAttributes = "#{file_name} "
  	attributes.each do |attribute|
  		tempAttributes += attribute.name.to_s
  		if !attribute.type.nil?
  			tempAttributes += ':' + attribute.type.to_s
  			if attribute.has_index?
  				tempAttributes += ':index' 
  			end
  		end
  		tempAttributes += ' '

  	end

  	generate "resource", "#{tempAttributes}"

    # Creating the controller
    template "lumni_controller.rb.tt", "app/controllers/#{file_name.pluralize.underscore}_controller.rb", force: true

    # Adjust migration
    inject_into_file Dir["db/migrate/*#{file_name.pluralize.underscore}.rb"][0], before: "t.timestamps\n" do <<-'RUBY'
      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

    RUBY
    end

    # Adjust model
    inject_into_file "app/models/#{file_name.singularize.underscore}.rb", after: "class #{file_name.singularize.camelize} < ApplicationRecord\n" do <<-'RUBY'
      
      resourcify
      audited
    RUBY
    end

    # Creating views
    template "lumni_new.rb.tt", "app/views/#{file_name.pluralize.underscore}/new.html.erb"
    template "lumni_index.rb.tt", "app/views/#{file_name.pluralize.underscore}/index.html.erb"
    template "lumni_edit.rb.tt", "app/views/#{file_name.pluralize.underscore}/edit.html.erb"


    # Creating Template Records
    template_text = "newTemplate = FormTemplate.create({name: 'Default #{file_name.underscore.humanize}', object: '#{file_name.singularize.camelize}',default: true})\n"
    template_text += "attributes = #{attributes.map{|a| {name: a.name, type: a.type}}}\n"
    template_text += "attributes.each_with_index do |attribute,index|\n"
    template_text += "  tempFormat = 'string'\n"
    template_text += "  if !attribute[:type].nil?\n"
    template_text += "    tempFormat = attribute[:type].to_s\n"
    template_text += "  end\n"
    template_text += "  FormField.create({name: attribute[:name].to_s,status: 'active',order: index,row: 1,grid: 6,form_template_id: newTemplate.id, format: tempFormat})\n"
    template_text += "end\n"
    template_text += "# Assigning the new template\n"
    template_text += "TeamProfile.kept.each_with_index do |profile, index|\n"
    template_text += "  TeamProfileTemplate.create({form_template_id: newTemplate.id, team_profile_id: profile.id, controller_name: '#{file_name.pluralize.underscore}'})\n"
    template_text += "end\n"

    inject_into_file Dir["db/migrate/*#{file_name.pluralize.underscore}.rb"][0],"\n#{template_text}\n", after: "t.timestamps\n    end\n"

  end
end
