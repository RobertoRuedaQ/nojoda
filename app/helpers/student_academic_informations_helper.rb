module StudentAcademicInformationsHelper
	def header_application_student_academic_information target_info
		target_info.map{|academic| render('/students/partial/academic_information_header',academic: academic)}
	end
end
