class SendEmailsToPlatzi < ApplicationJob
  queue_as :worker

	def perform(*args)
    @mexico = Roo::Spreadsheet.open('https://lumni-public.s3-us-west-2.amazonaws.com/email-files/send_emails_platzi/PlatziMexico.xlsx')
    @colombia = Roo::Spreadsheet.open('https://lumni-public.s3-us-west-2.amazonaws.com/email-files/send_emails_platzi/PlatziColombia.xlsx')
    #@mexico = Roo::Spreadsheet.open('https://lumni-public.s3-us-west-2.amazonaws.com/email-files/send_emails_platzi/example.xlsx')
    #@colombia = Roo::Spreadsheet.open('https://lumni-public.s3-us-west-2.amazonaws.com/email-files/send_emails_platzi/example.xlsx')
    #mexico
    send_email(@mexico, 14, 255)
    #colombia
    send_email(@colombia, 12, 254)
  end

  def send_email(document, company_id, comunication_id)
    sheet = document.sheet('platzi')
    user_ids = sheet.column(1) - ['ID']
    sents = 0
    user_ids.each do |user_id|
      user = User.find(user_id)
      puts "Sending email for #{user.email}"
      CommunicationMailer.invite_mail_without_token(comunication_id, company_id, user.email, user_id: user.id).deliver_now
      puts "Emaril sent for #{user.email}"
      sents += 1
    end

    puts "Emails sents #{sents}"
    puts "emails sents for #{company_id}"
  end
end

