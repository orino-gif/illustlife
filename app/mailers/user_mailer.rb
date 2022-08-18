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
  
  def info(notification_user, resume_user)
      @notification_user = notification_user
      @resume_user = resume_user
      mail(
        to: @notification_user.email,
        subject: "[イラストライフ運営局]#{@resume_user.nickname}さんがリクエスト受付を開始しました。"
      )
  end
  
  def info_withdrawal(creator)
      @creator = creator
      mail(
        to: "#{@creator.user.email},#{ENV['ADMINISTRATOR_MAIL']}",
        subject: "[イラストライフ運営局]#{@creator.user.nickname}さんからの引き落とし申請を受付ました。"
      )
  end
  
  def card_declined_email(sender,receiver,requests)
    @sender = sender
    @receiver = receiver
    @request = requests
    mail(
        to: "#{@receiver.email},#{ENV['ADMINISTRATOR_MAIL']}",
        subject: "[イラストライフ運営局]#{@sender.nickname}さんのクレジットカード決済不備によるキャンセルの件。"
      )
  end
end
