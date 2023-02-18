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
    path = Path.new
    
    path.url = params[:char][:url]
    path.img = params[:char][:img]
    if path.save
      @char.path_id = path.id
      # p 'aaa' + params[:char][:id].to_s
      @char.ttl_id = params[:char][:id]
      if @char.save
        noti('追加しました', root_path)
      else
        alt('失敗しました')
      end
    else
      alt('リンク作成に失敗しました')
    end
  end
  
  def show
    @chars = Char.joins(:path).all
    @char = Char.joins(:ttl).all.find_by(path_id: params[:id])
    p @char
    @path = Path.find_by(id: params[:id])
  end
  
  private
  def chars_params
    params.require(:char).permit(:c_name, :path_id, :ttl_id)
  end
end
