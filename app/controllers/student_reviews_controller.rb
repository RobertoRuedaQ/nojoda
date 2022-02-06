class StudentReviewsController < ApplicationController
	def index
		@student_review = StudentReview.lumniStart(params,current_company, list: current_user.template('StudentReview','student_reviews',current_user))
		contactStudentReview = @student_review.lumniSave(params,current_user, list: current_user.template('StudentReview','student_reviews',current_user))
		lumniClose(@student_review,contactStudentReview)
	end

	def new
		@student_review = StudentReview.lumniStart(params,current_company, list: current_user.template('StudentReview','student_reviews',current_user))
		contactStudentReview = @student_review.lumniSave(params,current_user, list: current_user.template('StudentReview','student_reviews',current_user))
		lumniClose(@student_review,contactStudentReview)
	end

	def create
		@student_review = StudentReview.lumniStart(params,current_company, list: current_user.template('StudentReview','student_reviews',current_user))
		contactStudentReview = @student_review.lumniSave(params,current_user, list: current_user.template('StudentReview','student_reviews',current_user))
		lumniClose(@student_review,contactStudentReview)
	end

	def edit
		@student_review = StudentReview.lumniStart(params,current_company, list: current_user.template('StudentReview','student_reviews',current_user))
		contactStudentReview = @student_review.lumniSave(params,current_user, list: current_user.template('StudentReview','student_reviews',current_user))
		lumniClose(@student_review,contactStudentReview)
	end

	def update
		@student_review = StudentReview.lumniStart(params,current_company, list: current_user.template('StudentReview','student_reviews',current_user))
		contactStudentReview = @student_review.lumniSave(params,current_user, list: current_user.template('StudentReview','student_reviews',current_user))
		lumniClose(@student_review,contactStudentReview)
	end
	def destroy
		@student_review = StudentReview.lumniStart(params,current_company, list: current_user.template('StudentReview','student_reviews',current_user))
		contactStudentReview = @student_review.lumniSave(params,current_user, list: current_user.template('StudentReview','student_reviews',current_user))
		lumniClose(@cluster,contactStudentReview)
	end
end