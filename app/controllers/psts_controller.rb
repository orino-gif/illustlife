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
    @worth = Worth.find_by(pst_id: @pst.id)
  end
    
  def update
    
  end
  
  private
  
  def psts_params
    params.require(:pst).permit(:ttl,:dtl_id,:pass_id,:tag_id, :illust, :minor,
    :is_ai, :cmt, :up_id)
  end
end
