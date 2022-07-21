class UserMailer < ApplicationMailer
  
  def request_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: "#{@receiver.email},#{ENV['ADMINISTRATOR_MAIL']}",
        subject: "[イラストライフ運営局]#{@sender.nickname}さんからリクエストが送信されました。"
      )
  end
  
  def refusal_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: "#{@sender.email},#{ENV['ADMINISTRATOR_MAIL']}",
        subject: "[イラストライフ運営局]#{@sender.nickname}さんからのリクエストが拒否されました"
      )
  end

  def consent_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: "#{@sender.email},#{ENV['ADMINISTRATOR_MAIL']}",
        subject: "[イラストライフ運営局]#{@sender.nickname}さんからのリクエストが承認されました"
      )
  end
  
  def suspension_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: "#{@sender.email},#{ENV['ADMINISTRATOR_MAIL']}",
        subject: "[イラストライフ運営局]#{@sender.nickname}さんの作業が中断されました"
      )
  end
  
  def deliver_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: "#{@sender.email},#{ENV['ADMINISTRATOR_MAIL']}",
        subject: "[イラストライフ運営局]#{@sender.nickname}さんへの納品が完了しました。"
      )
  end
  
  def rework_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: "#{@sender.email},#{ENV['ADMINISTRATOR_MAIL']}",
        subject: "[イラストライフ運営局]#{@sender.nickname}さんへの納品の手戻りがありました。"
      )
  end
  
  def info(user)
      @user = user
      mail(
        to: @user.email,
        subject: "[イラストライフ運営局]#{@user.nickname}さんがリクエスト受付を開始しました。"
      )
  end
end
