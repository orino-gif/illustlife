module ApplicationHelper
  # アイコンを表示。
  def icon(cre, scss)
    if cre.icon?
      link_to image_tag(cre.icon.url,class: "#{scss} rounded-circle fit_c"),
      cre_path(cre.user_id)
    else
      link_to image_tag('/img/mobu.png',class: "#{scss} rounded-circle fit_c"),
      cre_path(cre.user_id)
    end
  end
  
  def noti(info)
    redirect_to request.referer, notice: info
  end
  
  def alt(info)
    redirect_to request.referer, alert: info
  end
  
  def send_msg(mail, tx, rx, noti)
    @tx = tx
    @rx = rx
    UserMailer.send(mail,@tx,@rx).deliver_later
    noti(noti)
  end
end
