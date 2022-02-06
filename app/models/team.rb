class Team < User
  resourcify
  audited


  after_commit :flush_user

  def flush_user
    Rails.cache.delete(['User',self.id])
    Rails.cache.delete(['Student',self.id])
    Rails.cache.delete(['Applicant',self.id])
    Rails.cache.delete(['Profile',self.id])
    Rails.cache.delete(['super_user_tag',self.id])    
  end


end
