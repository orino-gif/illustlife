class Expired 
  def self.notice
    date = Date.today-14
    @requests = Request.where("created_at >= ? AND created_at < ?", date, date + 1).where(status:'承認待ち')
    @requests.each do |request| 
      request.status = '期限切れ'
      request.save
    end
  end
end

Expired.notice