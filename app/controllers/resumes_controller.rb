class ResumesController < ApplicationController
  before_action :authenticate_user!, except: [:create]

  def new
    @resume = Resume.new
    
    # クリエーター情報のidから再開する者のレコードを取得
    @creator = Creator.find(params[:id])
  end
  
  def create
    @resume = Resume.new(resume_params)
    
    # 再開者のidをresume_userカラムに登録
    @resume.resume_user = params[:resume][:resume_user]
    #現在ログイン中のユーザーのidをnotification_userに登録
    @resume.notification_user = current_user.id
    
    if @resume.save
      redirect_to "/resumes/#{current_user.id}", notice: '再開通知を設定しました'
    end
  end
  
  def show
    # 登録した再開者達のidを表示する為に利用
    @resumes = Resume.where(notification_user:current_user.id)
    
    # 指定した再開者の削除ボタンが押された場合、レコードを削除
    if params[:record_delete]
      Resume.find(params[:record_delete]).delete
    end
  end

  private
  
  def resume_params
    params.permit(:resume_user, :notification_user)
  end
end
