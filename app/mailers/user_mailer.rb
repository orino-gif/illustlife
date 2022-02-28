class UserMailer < ApplicationMailer
  
  def request_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: @receiver.email,
        subject: "[イラストライフ運営局]#{@sender.nickname}さんからリクエストが送信されました。"
      )
  end
  
  def refusal_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: @sender.email,
        subject: "[イラストライフ運営局]#{@sender.nickname}さんからのリクエストが拒否されました"
      )
  end

  def consent_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: @sender.email,
        subject: "[イラストライフ運営局]#{@sender.nickname}さんからのリクエストが承認されました"
      )
  end
  
  def deliver_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: @sender.email,
        subject: "[イラストライフ運営局]#{@sender.nickname}さんへの納品が完了しました。"
      )
  end
  
  def rework_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: @sender.email,
        subject: "[イラストライフ運営局]#{@sender.nickname}さんへの納品の手戻りがありました。"
      )
  end
end
