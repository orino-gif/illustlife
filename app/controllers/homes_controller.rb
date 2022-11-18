class HomesController < ApplicationController

  def index
    @cres = Creator.where.not(hdr: nil).order(created_at: 'DESC')

    # @reqs = Request.where(status: '納品完了')
    @works = Work.all
  end
end
