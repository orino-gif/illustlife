class StoriesController < ApplicationController
  include ApplicationHelper
  def new
    @story = Story.new
  end

  def create
    @story = Story.new(stories_params)
    if @story.save
      noti('追加しました', ttl_path(@story.ttl_id))
    else
      alt('失敗しました')
    end
  end
  
  def show
    @story = Story.find_by(id: params[:id])
    @ttl = Ttl.find_by(id: params[:ttl_id])
  end
  
  private
  def stories_params
    params.require(:story).permit(:ttl_id,:ep)
  end
end
