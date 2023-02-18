class TtlsController < ApplicationController
  include ApplicationHelper
  def index
    @ttls = Ttl.joins(:path).all
  end
  def new
    @ttl = Ttl.new
    @path = Path.new
  end

  def create
    @ttl = Ttl.new(chars_params)
    @path = Path.new
    @path.url = params[:ttl][:url]
    @path.img = params[:ttl][:img]
    if @path.save
      @ttl.path_id = @path.id
      if @ttl.save
        noti('追加しました', ttls_path)
      else
        alt('失敗しました')
      end
    else
      alt('リンク作成に失敗しました')
    end
  end
  
  def show
    @ttl = Ttl.find_by(id: params[:id])
    @path = Path.find_by(id: params[:id])
  end
  
  private
  def chars_params
    params.require(:ttl).permit(:t_name, :genre, :com, :pub, :serial, :auth)
  end
end
