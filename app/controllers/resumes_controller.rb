class ResumesController < ApplicationController
  before_action :authenticate_user!, except: [:create]

  def new
    @resume = Resume.new
    # クリエーター情報のidから再開する者のレコードを取得
    @cre = Creator.find(params[:id])
  end
  
  def create
    @resume = Resume.new(resume_params)
    # 再開者のidをre_idカラムに登録
    @resume.re_id = params[:resume][:re_id]
    #現在ログイン中のユーザーのidをnoti_idに登録
    @resume.noti_id = current_user.id
    if @resume.save
      redirect_to "/resumes/#{current_user.id}", notice: '再開通知者を登録完了'
    end
  end
  
  def show
    # 登録した再開者達のidを表示する為に利用
    @resumes = Resume.where(noti_id: current_user.id)
    # 指定した再開者の削除ボタンが押された場合、レコードを削除
    if params[:record_delete]
      Resume.find(params[:record_delete]).delete
    end
  end

  private
  
  def resume_params
    params.permit(:re_id, :noti_id)
  end
end
