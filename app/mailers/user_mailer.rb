class UserMailer < ApplicationMailer
  default from: 'xr274375@fc5.so-net.ne.jp'

  def Approval_email(user,requests)
    @user = user
    @requests = requests
    mail(
        to: @user.email,
        subject: '[イラストライフ運営局]承認依頼'
      )
  end
end
