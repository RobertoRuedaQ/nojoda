class UniversityCourseGrade < ApplicationRecord
      
      resourcify
      audited
  belongs_to :university_grade, touch: true

  after_update :validate_if_done

  def validate_if_done
    if self.final_score.present? && ["approved", "failed", "withdrawal"].include?(self.status)
      self.update_column('done', true)
    end
  end

end
