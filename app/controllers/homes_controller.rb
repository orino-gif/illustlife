class HomesController < ApplicationController
  def index
    @creators = Creator.all
    @requests = Request.all
  end
end
