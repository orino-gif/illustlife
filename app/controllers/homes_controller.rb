class HomesController < ApplicationController
  def index
    @cres = Cre.joins(:pfm,:user).order(evl: 'DESC', created_at: 'DESC')
    @ovrs = Ovr.all
    @expors = Expor.where.not(id: Ovr.all.select(:expor_id))
  end
end