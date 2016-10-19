class NotificationMailer < ApplicationMailer
  default from: "communitygrows2@gmail.com"
  def announcement_email(user)
  	@user = user
  	# @announcement = announcement
    mail(to: @user.email, subject: 'New Announcement Created')
  end
end
