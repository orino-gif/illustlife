class ResumesController < ApplicationController
  before_action :authenticate_user!, except: [:create]

  def new
    @resm = Resm.new
    # クリエーター情報のidから再開する者のレコードを取得
    @cre = Cre.find(params[:id])
  end
  
  def create
    @resm = Resm.new(resm_params)
    # 再開者のidをre_idカラムに登録
    @resm.re_id = params[:resm][:re_id]
    #現在ログイン中のユーザーのidをnoti_idに登録
    @resm.noti_id = current_user.id
    if @resm.save
      redirect_to "/resms/#{current_user.id}", notice: '再開通知者を登録完了'
    end
  end
  
  def show
    # 登録した再開者達のidを表示する為に利用
    @resms = Resm.where(noti_id: current_user.id)
    # 指定した再開者の削除ボタンが押された場合、レコードを削除
    if params[:record_delete]
      Resm.find(params[:record_delete]).delete
    end
  end

  private
  
  def resm_params
    params.permit(:re_id, :noti_id)
  end
end
