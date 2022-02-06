include LumniModeling

class MentoryEmpleabilityAcceptanceService
  def self.for(user_id)
    new(user_id).perform
  end

  def initialize(user_id)
    @user = User.find(user_id)
  end

  def perform
    if @user.present?
      user_email = @user.email
      user_hash = {}
      user_hash[user_email] = []

      mentory_disbursement_value =  280_000
      empleability_disbursement_value =  380_000
      date = Time.zone.now
      disbursement_date = "#{date.year}-#{date.month}-#{date.day}"
      first_disbursement = {
        currency: 'COP',
        disbursement_case:'mentory',
        student_value: mentory_disbursement_value,
        company_value: mentory_disbursement_value,
        forcasted_date: disbursement_date,
        status: 'active'
      }

      second_disbursement = {
      currency: 'COP',
      disbursement_case:'empleability',
      student_value: empleability_disbursement_value,
      company_value: empleability_disbursement_value,
      forcasted_date: disbursement_date,
      status: 'active'
      }
      user_hash[user_email] << first_disbursement
      user_hash[user_email] << second_disbursement
      user_hash.keys.each do |email|
        target_info = user_hash[email].nil? ? [] : user_hash[email]
        isa = Isa.joins(:user).find_by(users: { email: email }, status: 'active')
        add_disbursement_modeling isa, target_info, 'mentory_empleability'
      end

    end
  end
end