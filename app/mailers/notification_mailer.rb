class NotificationMailer < ApplicationMailer
  default from: "from@example.com"
  def announcement_email(user)
  	@user = user
    mail(to: @user.email, subject: 'Announcement Email')
  end
end
