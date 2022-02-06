module Api::V1
  class StudentsController < ApiController
    before_action :set_student, only: [:find]

    def find
      result = {}

      if @student
        result = {
          email: @student.email,
          first_name: @student.first_name,
          last_name: @student.last_name
        }
      end

      render json: { data: { student: result}}, status: 200
    end


    private

    def set_student
      return unless params[:email].present?

      @student = Student.find_by(email: params[:email])
    end
  end
end