class UserMailer < ApplicationMailer
  def notification(url, email)
    @url = url
    mail(to: email, subject: 'A problem occured!')
  end
end
