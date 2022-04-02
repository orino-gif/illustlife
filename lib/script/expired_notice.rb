class Expired
  def self.notice
    date = Date.today-1
    p date
    @requests = Request.where("created_at >= ? AND created_at < ?", date, date + 1)
    p @requests
  end
end

Expired.notice