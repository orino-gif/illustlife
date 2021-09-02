class HomeController < ApplicationController
  def index
    @creators = Creator.all
  end
end
