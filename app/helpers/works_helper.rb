module WorksHelper
  # カード決済
  def card_settlement(tx, rx, work)
    if @card = Card.find_by(user_id: tx.id)
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      begin
        Payjp::Charge.create(:amount => params[:amount],
        :customer => @card.cus_id, :currency => 'jpy')
        UserMailer.consent(tx, rx).deliver_later
        noti('リクエストを承諾しました')
      rescue Payjp::PayjpError => e
        p "例外エラー:" + e.to_s
        work.request.stts = 'キャンセル'
        # 承認者へ決済不備によるキャンセルを知らせる
        UserMailer.declined(tx, rx, work.request).deliver_later
        alt('購入者側の問題でキャンセルされました')
      end
    else
      work.request.stts = 'キャンセル'
      alt('購入者側の問題でキャンセルされました')
    end
  end
  
  def perf_update(perf, req, tx, rx)
    @tx = tx
    @rx = rx
    if false == req.work.rework
      perf.pic += 1
      perf.eval += 10
      perf.sales += req.money
      perf.wdl += req.money
      req.work.d_time = Time.now
    end
    UserMailer.del(@tx, @rx).deliver_later
    noti('依頼者への納品完了のメールを送信しました')
  end
end
