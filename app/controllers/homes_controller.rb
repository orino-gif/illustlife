class HomesController < ApplicationController
  def index
    @cres = Cre.joins(:pfm,:user).order(evl: 'DESC', created_at: 'DESC')
    @ovrs = Ovr.all
    if not Ovr.where.not("expor_id LIKE ?","%*%").empty?
      @expors = Expor.joins(:ovrs).merge(Ovr.where.not("expor_id LIKE ?","%*%"))
    else
      @expors = Expor.all
    end
  end
end