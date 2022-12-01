class HomesController < ApplicationController
  def index
    @cres = Cre.joins(:pfm).order(evl: 'DESC')
    p @cres
  end
end