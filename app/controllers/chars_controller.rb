class CharsController < ApplicationController
  include ApplicationHelper
  require "date"
  def index
  end
  def new
    @char = Char.new
    @thr = Thr.new
  end

  def create
    @char = Char.new(chars_params)
    thr = Thr.new
    
    thr.url = params[:char][:url]
    thr.img = params[:char][:img]
    if thr.save
      @char.thr_id = thr.id
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
    @chars = Char.joins(:thr).all
    @char = Char.joins(:ttl).all.find_by(thr_id: params[:id])
    @thr = Thr.find_by(id: params[:id])
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
        when '共感する'
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
    params.require(:char).permit(:c_name, :cause, :thr_id, :ttl_id)
  end
end
