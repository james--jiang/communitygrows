class NotificationMailer < ApplicationMailer
  default from: "from@example.com"
  def announcement_email(user, announcement)
  	@user = user
    mail(to: @user.email, subject: 'New Announcement Created')
  end
end
