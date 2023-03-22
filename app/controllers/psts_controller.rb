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
    if @pst.save
      noti('追加しました', root_path)
    else
      alt('失敗しました')
    end
  end
  
  def show
    
  end
    
  def update
    
  end
  
  private
  
  def psts_params
    params.require(:pst).permit(:ttl,:dtl_id,:pass_id,:tag_id, :illust, :minor,
    :is_ai, :cmt, :up_id)
  end
end