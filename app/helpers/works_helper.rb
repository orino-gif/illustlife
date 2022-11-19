module WorksHelper
  def set_works()
    if params[:request_id].nil?
      @req = Request.find(params[:id])
    else
      @req = Request.find(params[:request_id])
    end
    users = User.find(@req.tx_id, @req.rx_id);
    @tx = users[0]; @rx = users[1]; 
    @work = Work.find_by(request_id: @req.id)
  end
  
  def payment(tx)
    if @card = Card.find_by(user_id: tx.id)
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      cpl = false
      begin
        Payjp::Charge.create(:amount => params[:amount],
        :customer => @card.cus_id, :currency => 'jpy')
        cpl = true
      rescue Payjp::PayjpError => e
        p "例外エラー:" + e.to_s
      end
    end
    return cpl
  end
  
  def perf_upd(perf, req)
    if false == req.work.rework
      perf.pic += 1
      perf.eval += 10
      perf.sales += req.money
      perf.wdl += req.money
      req.work.d_time = Time.now
    end
  end
  
  def butn(name,req)
    button_to(name, work_path(req.id), {method: :get, params:{stts: name,
    request_id: req.id}})
  end
  
  def down(req_id)
    work = Work.find_by(request_id: req_id)
    if work.images?
      work.images.each do |image|
        send_data(image.read, filename: "download#{File.extname(image.path)}")
      end
    end
  end
end