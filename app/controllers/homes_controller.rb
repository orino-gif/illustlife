class HomesController < ApplicationController

  def index
    @creators = Creator.all.order(number_of_works: 'DESC')
    @requests = Request.all
  end
end
