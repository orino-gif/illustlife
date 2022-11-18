class UserMailer < ApplicationMailer
  def req(tx, rx)
    @tx = tx
    @rx = rx
    mail(to: "#{@rx.email}, #{ENV['ADMIN']}", subject: "[#{ENV['APP_NAME']}]"+ \
    @tx.nick + 'さんからリクエストが送信されました')
  end
  def refusal(tx, rx)
    @tx = tx
    @rx = rx
    mail(to: "#{@tx.email}, #{ENV['ADMIN']}", subject: "[#{ENV['APP_NAME']}]"+ \
    @tx.nick + 'さんからのリクエストが拒否されました')
  end
  def consent(tx, rx)
    @tx = tx
    @rx = rx
    mail(to: "#{@tx.email}, #{ENV['ADMIN']}", subject: "[#{ENV['APP_NAME']}]"+ \
    @tx.nick + 'さんからのリクエストが承認されました')
  end
  def quit(tx, rx)
    @tx = tx
    @rx = rx
    mail(to: "#{@tx.email}, #{ENV['ADMIN']}", subject: "[#{ENV['APP_NAME']}]"+ \
    @tx.nick + 'さんの作業が中断されました')
  end
  def del(tx, rx)
    @tx = tx
    @rx = rx
    mail(to: "#{@tx.email},#{ENV['ADMIN']}", subject: "[#{ENV['APP_NAME']}]"+ \
    @tx.nick + 'さんへの納品が完了しました')
  end
  def rework(tx, rx)
    @tx = tx
    @rx = rx
    mail(to: "#{@tx.email},#{ENV['ADMIN']}", subject: "[#{ENV['APP_NAME']}]"+ \
    @tx.nick + 'さんへの納品の手戻りがありました')
  end
  def resume(notification_user, resume_user)
    @notification_user = notification_user
    @resume_user = resume_user
    mail(to: @notification_user.email, subject: "[#{ENV['APP_NAME']}]"+ \
    @resume_user.nick + 'さんがリクエスト受付を開始しました')
  end
  def wdl(creator)
    @cre = creator
    mail(to: "#{@cre.user.email},#{ENV['ADMIN']}",
    subject: "[#{ENV['APP_NAME']}]" + @cre.user.nick + \
    'さんからの引き落とし申請を受付ました')
  end
  def declined(tx, rx, requests)
    @tx = tx
    @rx = rx
    @req = requests
    mail(to: "#{@rx.email},#{@tx.email},#{ENV['ADMIN']}",
    subject: "[#{ENV['APP_NAME']}]" + @tx.nick + \
    'さんのクレジットカード決済不備によるキャンセルの件')
  end
end
