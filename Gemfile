source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
gem "mini_magick"
gem 'image_processing', '~> 1.2'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'geocoder'

# Authentication
gem 'devise'
gem 'devise-i18n'

# Authorization
gem 'pundit'
gem "rolify"

# Approval flow
gem 'approval'

# Track Changes
gem "audited", "~> 4.7"

# Soft delete
gem 'discard', '~> 1.0'

gem 'rack-cors'

# Emails 
#gem 'gibbon', '~> 3.2'
gem 'sendgrid-ruby'

# Automatic action mailer url
gem "action_mailer_auto_url_options"

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false


# Complements Active Storage to be used in Heroku
gem "aws-sdk-s3", require: false

# Airbreak
gem 'airbrake', '~> 9.2.0'

# Fixing rails-ujs
gem 'rails-ujs'

# Adding sidkiq 
gem 'sidekiq'
gem 'sidekiq-scheduler'



gem 'sinatra', github: 'sinatra/sinatra'

# Gems for migration
gem 'restforce', '~> 3.1.0'

# Setup app for API integration
gem 'rest-client'


# locations
gem 'city-state'

# cache
gem 'dalli'
gem 'memcachier'
gem 'redis'

# Drag and drop
gem 'jquery-ui-rails'

# Emails Bootstrap
gem 'bootstrap-email'

# PDF gems
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'pdf-reader-turtletext'

# Security
gem "recaptcha"


# Machine Learning
 gem 'rumale', '~> 0.19.1'
# gem 'numo-linalg'
 gem 'parallel'

# To get numbers to letters in our contracts
gem 'numbers_and_words'

# Searcher
gem 'ransack'
gem 'will_paginate', '~> 3.1.0'
gem 'pg_search'

# patterns design
gem 'interactor', '~> 3.0'    

# Excel Files Manager
gem "roo", "~> 2.8.0"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Autoprefixer
gem "autoprefixer-rails"

# Diag DB
gem 'railroady'

# monitor to identify performance issues
gem 'newrelic_rpm'
gem 'newrelic-infinite_tracing'

gem 'groupdate'

# Finance
# The present value formula is not well designed in this gem!
#gem 'finance'
gem 'xirr'

# Charts
gem "chartkick"



# haml
gem 'haml'


#heroku-api
gem 'platform-api'

# mercado pago
gem 'mercadopago-sdk'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adding performing measure
  gem 'rack-mini-profiler' 
  gem 'pry'
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
  #check the emails in a pop up
  gem "letter_opener"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 4.0'
end
