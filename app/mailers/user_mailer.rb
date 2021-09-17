class UserMailer < ApplicationMailer
  default from: 'xr274375@fc5.so-net.ne.jp'

  def request_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @requests = requests
    mail(
        to: @receiver.email,
        subject: "[イラストライフ運営局]#{@sender.nickname}さんからリクエストが送信されました。"
      )
  end
  
  def refusal_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @requests = requests
    mail(
        to: @sender.email,
        subject: "[イラストライフ運営局]#{@sender.nickname}さんからのリクエストが拒否されました"
      )
  end
  

  def consent_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @requests = requests
    mail(
        to: @sender.email,
        subject: "[イラストライフ運営局]#{@sender.nickname}さんからのリクエストが承認されました"
      )
  end
  
  def deliver_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @requests = requests
    mail(
        to: @sender.email,
        subject: "[イラストライフ運営局]#{@sender.nickname}さんへの納品が完了しました。"
      )
  end
end
