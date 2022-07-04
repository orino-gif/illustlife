class ResumesController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  def index
  end
  
  def new
    @resume = Resume.new
  end
  
  def create
    @resume = Resume.new(resume_params)
    @resume.resume_user =params[:resume][:resume_user]
    @resume.notification_user = current_user.id
    if @resume.save
      redirect_to request.referer, notice: '再開通知を設定しました'
    end
  end
  
  private
  
  def resume_params
    params.permit(:resume_user, :notification_user)
  end
end
