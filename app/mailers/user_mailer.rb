class UserMailer < ApplicationMailer
  default from: 'xr274375@fc5.so-net.ne.jp'

  def request_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @requests = requests
    mail(
        to: @receiver.email,
        subject: "[イラストライフ運営局]#{@sender}さんからリクエストが送信されました。"
      )
  end
  
  def approval_email(user,requests)
    @user = user
    @requests = requests
    mail(
        to: @user.email,
        subject: "[イラストライフ運営局]#{@user}からのリクエストが承認されました"
      )
  end
  
  def deliver_email(user,requests)
    @user = user
    @requests = requests
    mail(
        to: @user.email,
        subject: "[イラストライフ運営局]#{@user}からのリクエストが承認されました"
      )
  end
end
