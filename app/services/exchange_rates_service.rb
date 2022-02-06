require 'rest-client'

class ExchangeRatesService
  def self.for(base, target, date)
    new(base, target, date).perform
  end

  def initialize(base, target, date)
    @base = base
    @target = [target].flatten.join(',')
    @date = date.strftime('%Y-%m-%d')
    @client
  end

  def perform
    return request
  end

  private

  def request
    begin
      request = RestClient.get(
        "#{service_url}/#{@date}" ,
        { params: {
          access_key: api_key,
          base: @base,
          symbols: @target
          }
        }
      )
      case request.code
      when 200
        process_success(request.body)
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.response
    end
  end

  def process_success(body)
    parsed = JSON.parse(body)
    parsed['success'] ? build_answer(parsed) : {}
  end

  def build_answer(answer)
    {
      currency_base: @base,
      currency_target: @target,
      value:  answer['rates'][@target],
      date: answer['date']
    }
  end

  def service_url
    return 'http://data.fixer.io/api'
  end

  def api_key
    @api_key ||= ENV['FIXER_API_KEY']
  end
end