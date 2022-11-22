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
    set_works()
    if params[:stts]
      case params[:stts]
      when '拒否'
        send_msg('refusal', @tx, @rx, 'リクエストを拒否しました')
      when '製作中'
        if cpl = payment(@tx)
          send_msg('consent', @tx, @rx, 'リクエストを承諾しました')
        else
          UserMailer.declined(@tx, @rx, @work).deliver_later
          alt('購入者側の問題でキャンセルされました')
          @work.req.stts = 'キャンセル'
        end
      when '製作中断'
        @rx.cre.pfm.eval -= 20
        send_msg('quit', @tx, @rx, '作業を中断しました')
      when '納品'
        pfm_upd(@rx.cre.pfm, @req)
        send_msg('del', @tx, @rx, '納品完了のメールを送信しました')
      when '手戻し'
        @work.rework = true; @work.in_time = false
        send_msg('rework', @tx, @rx, '手戻りのメールを送信しました')
      end
      if 'キャンセル' != @work.req.stts
        @work.req.stts = params[:stts]
      end
      @work.save; @work.req.save; @rx.cre.pfm.save
    end
  end
  
  def download
    down(params[:req_id])
  end
  
  def update
    @work =  Work.find_by(req_id: params[:work][:req_id])
    if @work.update(works_params)
      redirect_to work_path(params[:id]), notice: '更新しました。'
    end
  end
  
  private
  def works_params
    params.require(:work).permit(:rework,{ images: [] })
  end
end