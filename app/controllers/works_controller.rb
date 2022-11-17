class WorksController < ApplicationController
  include ApplicationHelper
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(works_params)
    if @work.save
      redirect_to work_path(params[:id]), notice: '更新しました。'
    end
  end

  def show
    # リクエスト詳細ボタンが押された場合の処理
    if params[:request_id].nil?
      @req = Request.find(params[:id])
      @work = Work.find_by(request_id: params[:id])
      
    else
      @req = Request.find(params[:request_id])
      @work = Work.find_by(request_id: @req.id)
    end
    users = User.find(@req.tx_id, @req.rx_id)
    @tx = users[0]
    @rx = users[1]
    if params[:stts]
      case params[:stts]
      when '拒否'
        UserMailer.refusal(@tx, @rx).deliver_later
        noti('リクエストを拒否しました')
      when '製作中'
        card_settlement(@tx, @rx, @work)
      when '製作中断'
        @rx.creator.performance.eval -= 20
        UserMailer.quit(@tx, @rx).deliver_later
        noti('作業を中断しました')
      when '納品完了'
        perf_update(@rx.creator.performance, @req, @tx, @rx)
      when '手戻し'
        @req.work.rework = true
        @req.work.in_time = false
        UserMailer.rework(@tx, @rx).deliver_later
        noti('依頼者への手戻りのメールを送信しました')
      end
      if 'キャンセル' != @work.request.stts
        @work.request.stts = params[:stts]
      end
      @work.save
      @work.request.save
    end
  end
  
  def update
    @work =  Work.find_by(request_id: params[:work][:request_id])
    p @work
    if @work.update(works_params)
      redirect_to work_path(params[:id]), notice: '更新しました。'
    end
  end
  
  private
  def works_params
    params.require(:work).permit(:rework,:img1,:img2,:img3,:img4,:img5,:img6)
  end
end