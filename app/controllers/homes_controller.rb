class HomesController < ApplicationController

  def index
    @users = User.order(created_at: 'DESC')

    # @reqs = Req.where(status: '納品完了')
    @works = Work.all
  end
end
