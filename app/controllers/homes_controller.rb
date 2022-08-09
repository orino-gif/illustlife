class HomesController < ApplicationController

  def index
    @creators = Creator.all.order(evaluation_points: 'DESC').order(created_at: 'DESC')
    @requests = Request.all
  end
end
