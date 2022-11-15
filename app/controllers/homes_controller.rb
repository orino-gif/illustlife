class HomesController < ApplicationController

  def index
    @creators = Creator.where.not(header: nil).order(created_at: 'DESC')

    # @requests = Request.where(status: '納品完了')
    @works = Work.all
  end
end
