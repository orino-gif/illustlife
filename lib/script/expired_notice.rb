class Expired 
  def self.notice
    date = Date.today-3
    p date
    @requests = Request.where("created_at >= ? AND created_at < ?", date, date + 1).where(status:'承認待ち')
    p @requests
    @requests.each do |request| 
      request.status = '期限切れ'
      sender = User.find_by(nickname: request.sender)
      p sender
      receiver = User.find_by(nickname: request.receiver)
      p receiver
      UserMailer.refusal_email(sender, receiver, request).deliver_later

      request.save
    end
  end
end

Expired.notice