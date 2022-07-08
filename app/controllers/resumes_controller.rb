class ResumesController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  def index
  end
  
  def new
    @resume = Resume.new
    @creator = Creator.find(params[:id])
  end
  
  def create
    @resume = Resume.new(resume_params)
    @resume.resume_user =params[:resume][:resume_user]
    @resume.notification_user = current_user.id
    if @resume.save
      redirect_to resume_path(current_user.id), notice: '再開通知を設定しました'
    end
  end
  
  def show
    @notification_users = Resume.where(notification_user:current_user.id)
    if not params[:record_delete].nil?
      Resume.find(params[:record_delete]).delete
    end
  end

  private
  
  def resume_params
    params.permit(:resume_user, :notification_user)
  end
end
