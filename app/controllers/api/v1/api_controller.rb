module Api::V1
  class ApiController < ActionController::Base
    before_action :validate_authorization


    private

    def validate_authorization
      if http_auth_header != external_consumer_api
        render json: { data: { error: 'unauthorized, invalid api key' }}, status: 401
      end
    end

    def external_consumer_api
      ENV['EXTERNAL_CONSUMER_API']
    end
    
    def http_auth_header
      if request.env['HTTP_AUTHORIZATION'].present?
        return request.env['HTTP_AUTHORIZATION'].split(' ').last
      else
        return ''
      end
    end
  end
end