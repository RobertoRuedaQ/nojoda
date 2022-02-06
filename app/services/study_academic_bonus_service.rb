class StudyAcademicBonusService

  def self.for(user_questionnaire_id)
    new(user_questionnaire_id).perform
  end

  def initialize(user_questionnaire_id)
    @user_questionnaire = UserQuestionnaire.find(user_questionnaire_id)
    return if @user_questionnaire.nil?
    @bonus_year_value = 500000
  end


  def perform
    begin
      @program_to_fund = @user_questionnaire.user.funded_academic_information
      if @program_to_fund
        @application = @user_questionnaire.application
        @university_grade = @application.university_grade

        if @university_grade.academic_bonus.nil?
          isa = @user_questionnaire.user.active_isa.first
          fund = isa.fund
          score = get_score

          bonus_value = fund.bonus_value.to_f
          if bonus_value > 0
            porcentage_bonus_min_score = fund.bonus_min_score.to_f

            if is_final_score_valid?(porcentage_bonus_min_score)
              service = CreateAcademicBonusService.for(
                @user_questionnaire.user, Time.zone.now, generate_bonus_value
              )
              if service[:academic_bonus].present?
                @university_grade.update(academic_bonus_id: service[:academic_bonus].id)
              end
            end 
          end
        end
      end
    rescue StandardError => e
      return result_message(false, e)
    end
  end

  private

  def is_final_score_valid?(min_required_score)
    max_score = max_grade_scale_score.to_i
    return false if max_score == 0

    student_porcentage_score = ((get_score * 100) / max_score)

    return student_porcentage_score >= min_required_score
  end

  def get_score
    return 0 if @application.university_grade.nil?

    @application.university_grade.grade.to_f
  end

  def max_grade_scale_score
    begin
      scale = @university_grade.student_academic_information.score_scale
      scale = scale.split
      max_grade = scale.size == 3 ? scale.last : 0

      return max_grade
    rescue StandardError => e
      return 0
    end
  end

  def generate_bonus_value
    to_divide = (12 / @program_to_fund.disbursements_periodicity).to_f
    return (@bonus_year_value / to_divide).to_f
  end


  def result_message(success, error = '')
    return {
      success: success,
      error: error,
      user_questionnaire: @user_questionnaire
    }
  end
end