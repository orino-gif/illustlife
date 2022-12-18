class HomesController < ApplicationController
  def index
    @cres = Cre.joins(:pfm,:user).order(evl: 'DESC', created_at: 'DESC')
    @expors = Expor.all
  end
end