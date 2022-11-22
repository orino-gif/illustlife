class SetttingsController < ApplicationController
  
  def update
    @set =  Set.find_by(cre_id: params[:id])
    if @set.update(sets_params)
      redirect_to cre_path(params[:id]), notice: '設定情報を更新しました。'
    end
  end
  
  private
  
  def sets_params
    params.require(:set).permit(:recom, :min, :work_d, :start, :nsfw)
  end
end
