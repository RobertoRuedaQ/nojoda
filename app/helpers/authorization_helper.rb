module AuthorizationHelper

  def can_unapply_payment?
    it_is_able_to = [12, 57, 31541, 30656] #id de usuario

    it_is_able_to.include?(current_user.id)
  end


  def can_clone_funding_opportunity?
    it_is_able_to = [30656, 109, 18, 31040, 15, 31541]

    it_is_able_to.include?(current_user.id)
  end
end