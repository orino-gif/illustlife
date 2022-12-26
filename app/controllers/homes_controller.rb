class HomesController < ApplicationController
  def index
    @cres = Cre.joins(:pfm,:user).order(evl: 'DESC', created_at: 'DESC')
    @ovrs = Ovr.all
    @expors = Expor.joins(:ovrs).merge(Ovr.where.not("expor_id LIKE ?","%*%"))
  end
end