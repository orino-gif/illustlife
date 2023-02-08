class CharsController < ApplicationController
  include ApplicationHelper
  def index
  
  end
  def new
    @char = Char.new
    @path = Path.new
  end

  def create
    @char = Char.new(chars_params)
    @path = Path.new
    @path.url = params[:char][:url]
    @path.img = params[:char][:img]
    if @path.save
      @char.path_id = @path.id
      if @char.save
        noti('成功しました', root_path)
      else
        alt('失敗しました')
      end
    end
  end
  
  def show
  
  end
  
  private
  def chars_params
    params.require(:char).permit(:genre, :c_name, :ttl, :path_id, :c_img)
    
  end
end
