include LumniModeling

class EmergencyLivingExpensesService
  def self.for(user_email)
    new(user_email).perform
  end

  def initialize(user_email)
    @user_email = user_email
  end

  def perform
    user_hash = {}

    user_email = @user_email

    if user_email
      user_hash[user_email] = []

      disbursement_value =  1_066_000

      now = Time.zone.now
      disbursement_date = "#{now.year}-#{now.month}-#{now.day}"

      h = {
        currency: 'COP',
        disbursement_case:'emergency_living_expenses',
        student_value: disbursement_value,
        company_value: disbursement_value,
        forcasted_date: disbursement_date,
        status: 'active'
      }
      user_hash[user_email] << h

      user_hash.keys.each do |email|
        target_info = user_hash[email].nil? ? [] : user_hash[email]
        isa = Isa.joins(:user).find_by(users: { email: email }, status: 'active')
        add_disbursement_modeling isa, target_info, 'blackrock' # 1 = blackrcok
      end
    end
  end
end