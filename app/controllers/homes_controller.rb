class HomesController < ApplicationController

  def index
    @creators = Creator.where.not(header: nil)
      .order(evaluation_points: 'DESC').order(created_at: 'DESC')
      
    @requests = Request.where(status: '納品完了')
      .order(approval_day: 'DESC')
  end
end
