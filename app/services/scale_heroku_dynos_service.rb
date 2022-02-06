require 'platform-api'

class ScaleHerokuDynosService
  def self.call
    new().perform
  end

  def initialize; end

  def perform
    return rezise_dynos
  end

  private

  def rezise_dynos
    heroku.formation.update('lumniproduction', 'web', { quantity: new_size })
  end

  def new_size
    minimun_size = 2
    maximun_size = 3
    
    return minimun_size if weekend?

    new_size = maximun_size
    case get_time_of_day
    when 'early_morning', 'late_morning', 'early_afternoon', 'late_afternoon', 'early_evening'
      new_size = maximun_size
    when 'evening'
      new_size = minimun_size
    end

    return new_size
  end

  def weekend?
    today = Time.zone.now

    today.saturday? || today.sunday?
  end

  def current_size
    result = heroku.formation.info('lumniproduction', 'web')
    if result[:quantity].present?
      result[:quantity]
    else
      0
    end
  end

  def heroku
    @heroku ||= PlatformAPI.connect_oauth(api_key)
  end

  def api_key
    @api_key ||= ENV['HEROKU_API_KEY']
  end
  
  def get_time_of_day
    hour = Time.zone.now.hour
    
    if (hour >= 5 and hour <= 9)
      return 'early_morning'
    elsif (hour > 9 and hour <= 11)
      return 'late_morning'
    elsif (hour > 11 and hour <= 15)
      return 'early_afternoon'
    elsif (hour > 15 and hour <= 18)
      return 'late_afternoon'
    elsif (hour > 18 and hour <= 19)
      return 'early_evening'
    elsif (hour > 19 and hour <= 23)
      return 'evening'
    end
  end
end