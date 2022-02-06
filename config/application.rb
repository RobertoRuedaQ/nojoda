require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsStarter
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
	config.time_zone = 'Bogota'
	config.active_record.default_timezone = :local # Or :utc
  config.autoload_paths += %W(#{config.root}/app/lumni)
  config.autoload_paths += %W(#{config.root}/app/workers)
  config.autoload_paths += %W(#{config.root}/cron_jobs)
  config.ignored_paths = %W(/users/sign_in /users/sign_up /users/password /users/sign_out /users/confirm_password)
  config.active_job.queue_adapter = :sidekiq

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.to_prepare do
      Devise::Mailer.layout "example_mailer" # simple.haml or simple.erb
    end

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
  end
end

