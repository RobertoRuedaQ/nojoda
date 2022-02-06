class UserMailer < ApplicationMailer
  def confirmation_email
    make_bootstrap_mail(
      to: 'jcastillole@gmail.com',
      from: 'from@example.com',
      subject: 'Confirm your email',
    )
  end

  def statement_ready
    make_bootstrap_mail(
      to: 'jcastillole@gmail.com',
      from: 'from@example.com',
      subject: 'Statement Ready',
    )
  end


end
