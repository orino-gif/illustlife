class SettingsController < ApplicationController
  
  def update
    @setting =  Setting.find_by(creator_id: params[:id])
    if @setting.update(settings_params)
      redirect_to creator_path(params[:id]), notice: '設定情報を更新しました。'
    end
  end
  
  private
  
  def settings_params
    params.require(:setting).permit(:recommend, :minimum,
      :working, :opening, :nsfw)
  end
end
