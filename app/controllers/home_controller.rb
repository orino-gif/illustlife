class HomeController < ApplicationController
  
  def index
    @creators = Creator.all
    @requests = Request.all
  end
end
