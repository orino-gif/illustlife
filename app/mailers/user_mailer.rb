class UserMailer < ApplicationMailer
  default from: 'xr274375@fc5.so-net.ne.jp'

  def welcome_email
    mail(to: "orino0710@gmail.com", subject: '私の素敵なサイトへようこそ')
  end
end
