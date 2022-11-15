module WorksHelper
  # カード決済
  def card_settlement(sender, receiver, work)
    if @card = Card.find_by(user_id: sender.id)
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      begin
        Payjp::Charge.create(:amount => params[:amount],
        :customer => @card.customer_id, :currency => 'jpy')
        UserMailer.consent(sender, receiver).deliver_later
        noti('リクエストを承諾しました')
      rescue Payjp::PayjpError => e
        p "例外エラー:" + e.to_s
        work.request.stts = 'キャンセル'
        # 承認者へ決済不備によるキャンセルを知らせる
        UserMailer.declined(sender, receiver, work.request).deliver_later
        alt('購入者側の問題でキャンセルされました')
      end
    else
      work.request.stts = 'キャンセル'
      alt('購入者側の問題でキャンセルされました')
      work.request.save
    end
  end
  
  def perf_update(perf, req, tx, rx)
    @tx = tx
    @rx = rx
    if false == req.work.rework
      perf.painting += 1
      perf.evaluation += 10
      perf.earnings += req.money
      perf.withdrawal += req.money
      req.work.d_time = Time.now
    end
    UserMailer.del(@tx, @rx).deliver_later
    noti('依頼者への納品完了のメールを送信しました')
  end
end
