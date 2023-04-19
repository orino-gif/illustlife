class TtlsController < ApplicationController
  include ApplicationHelper
  def index
    @ttls = Ttl.joins(:thr).all
  end
  def new
    @ttl = Ttl.new
    @thr = Thr.new
  end

  def create
    @ttl = Ttl.new(chars_params)
    @thr = Thr.new
    @thr.url = params[:ttl][:url]
    @thr.img = params[:ttl][:img]
    if @thr.save
      @ttl.thr_id = @thr.id
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
    @thr = Thr.find_by(id: params[:id])
    @stories = Story.where(ttl_id: params[:id])
  end
  
  private
  def chars_params
    params.require(:ttl).permit(:t_name, :genre, :pub, :auth)
  end
end
