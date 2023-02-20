class CharsController < ApplicationController
  include ApplicationHelper
  require "date"
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
    @path = Path.find_by(id: params[:id])
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
      if @ip.updated_at + 86400 > DateTime.now
        @is_vaild = false
        @ip.updated_at = DateTime.now
        @ip.save
        p 'ccc'
      end
    end
  end
  
  def update
    @char = Char.find_by(id: params[:id])
    if @char.update(chars_params)
      p 'ddd' + @char.cause
      case @char.cause
        when 'ルックス'
          @char.looks += 1
        when '性格'
          @char.chara += 1
        when '能力'
          @char.ablty += 1
        when '強さ'
          @char.str += 1
        when '可愛さ'
          @char.cute += 1
        when 'エロさ'
          @char.ero += 1
        when '面白さ'
          @char.funny += 1
        when 'カッコ良さ'
          @char.cool += 1
      end
      @char.save
      noti('送信しました', request.referer)
    else
      alt('好きな理由を選択してください')
    end
  end
  
  private
  def chars_params
    params.require(:char).permit(:c_name, :cause, :path_id, :ttl_id)
  end
end
