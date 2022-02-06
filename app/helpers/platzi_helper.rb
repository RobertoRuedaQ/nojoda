module PlatziHelper
  def platzi_user?(user)
    return false if user.nil?

    company = user.company
    return false if company.nil?

    company.id == 12 || company.id == 14
  end

  def platzi_time_expired?
    Time.zone.now > '2020/11/01'
  end

  def platzi_information_controller?
    controller_name == 'platzi_information' || devise_controller? || !user_signed_in?
  end
end