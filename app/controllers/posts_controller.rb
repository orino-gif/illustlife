class PostsController < ApplicationController
  include ApplicationHelper
  require "date"
  before_action :authenticate_user!, only: [:create]
  def index
  end
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(posts_params)
    tag = Tag.new
    tag.txt = params[:post][:tag]
    tag.save
    @post.tag_id = tag.id
    if @post.save
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
  
  def posts_params
    params.require(:post).permit(:tag_id, :illust, :minor, :is_ai, :cmt, :up_id)
  end
end
