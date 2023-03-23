class PstsController < ApplicationController
  include ApplicationHelper
  require "date"
  before_action :authenticate_user!, only: [:create]
  def index
  end
  def new
    @pst = Pst.new
  end

  def create
    @pst = Pst.new(psts_params)
    
    dtl = Dtl.new
    dtl.cnt = params[:pst][:dtl]
    dtl.save
    
    pass = Pass.new
    pass.way = params[:pst][:img]
    pass.save
    
    tag = Tag.new
    tag.txt = params[:pst][:tag]
    tag.save
    
    @pst.dtl_id = dtl.id
    @pst.pass_id = pass.id
    @pst.tag_id = tag.id
    @pst.up_id = current_user.id
    worth = Worth.new
    if @pst.save
      worth.pst_id = @pst.id
      worth.save
      noti('追加しました', root_path)
    else
      alt('失敗しました')
    end
  end
  
  def show
    @pst = Pst.find_by(id: params[:id])
    @user = User.find_by(id: @pst.up_id )
    @address = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    @is_vaild = true
    @ip = Ip.find_by(addr: @address.to_s)
    if @ip.nil?
      @ip = Ip.new
      @ip.addr =request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
      @ip.save
    else
      p 'zzz' + (@ip.updated_at+86400).to_s
      p 'aaa' + DateTime.now.to_s
      if (not Rails.env.development?)
        if (@ip.updated_at + 86400 > DateTime.now)
          @is_vaild = false
          @ip.updated_at = DateTime.now
          @ip.save
          p 'ccc'
        end
      end
    end    
  end
    
  def update
    @worth = Worth.find_by(pst_id: params[:id])
    if @worth.update(worths_params)
      case params[:worth][:cause]
        when '絵柄'
          @worth.patt += 1
        when '可愛さ'
          @worth.cute += 1
        when 'エロさ'
          @worth.ero += 1
        when '美しさ'
          @worth.btfl += 1
        when 'カッコ良さ'
          @worth.cool += 1
        when '面白さ'
          @worth.funny += 1
        when '共感'
          @worth.sympa += 1
      end
      @worth.save
      noti('送信しました', request.referer)
    else
      alt('好きな理由を選択してください')
    end
  end
  
  private
  
  def psts_params
    params.require(:pst).permit(:ttl,:dtl_id,:pass_id,:tag_id, :illust, :minor,
    :is_ai, :cmt, :up_id)
  end
  
  def worths_params
    params.require(:worth).permit(:pst_id,:patt,:cute)
  end
  
end
