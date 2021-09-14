class UserMailer < ApplicationMailer
  default from: 'xr274375@fc5.so-net.ne.jp'

  def welcome_email(user)
    @user = user
    mail(
        to: @user.email,
        subject: '私の素敵なサイトへようこそ'
      )
  end
end
