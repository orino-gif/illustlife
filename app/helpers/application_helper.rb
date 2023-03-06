module ApplicationHelper
  def icon(cre, scss)
    if 'show' == controller.action_name || 'edit' == controller.action_name ||\
      'new' == controller.action_name
      if cre.icon?
        link_to image_tag(cre.icon.thumb250.url, alt: cre.user.nick,
        class: "#{scss} rounded-circle fit_c icon"),
        cre_path(cre.user_id)
      else
        link_to image_tag('/img/mobu.png', alt: 'モブキャラ',
        class: "#{scss} rounded-circle fit_c"),
        cre_path(cre.user_id)
      end
    else
      if cre.icon?
        link_to image_tag(cre.icon.thumb50.url, alt: cre.user.nick,
        class: "#{scss} rounded-circle fit_c icon"),
        cre_path(cre.user_id)
      else
        link_to image_tag('/img/mobu.png', alt: 'モブキャラ',
        class: "#{scss} rounded-circle fit_c"),
        cre_path(cre.user_id)
      end
    end
  end
  
  def disp_hdr(cre, scss)
    if cre.hdr?
      image_tag cre.hdr.url, alt: cre.user.nick,class: scss
    else
      image_tag '/img/nothing.png',alt:'モブキャラ',class: scss
    end
  end
  
  def noti(info, path = request.referer)
    redirect_to path, notice: info
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
