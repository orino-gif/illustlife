class HomesController < ApplicationController

  def index
    @creators = Creator.where.not(header: nil).order(evaluation_points: 'DESC').order(created_at: 'DESC')
    @requests = Request.where(status: '納品完了').order(updated_at: 'DESC')
  end
end
