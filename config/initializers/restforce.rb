Restforce.configure do |config|
  config.password = ENV['SALESFORCE_PASSWORD']
  config.security_token = ENV['SALESFORCE_SECURITY_TOKEN']
  config.host = ENV['SALESFORCE_URL']
  config.client_id = ENV['SALESFORCE_CLIENT_ID']
  config.client_secret = ENV['SALESFORCE_CLIENT_SECRET']
  config.api_version = ENV['SALESFORCE_API_VERSION']
end

