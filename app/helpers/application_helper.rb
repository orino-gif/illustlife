module ApplicationHelper
  # アイコンを表示。
  def icon(creator, appearance)
    if creator.icon?
      link_to image_tag(creator.icon.url, class: appearance),
      creator_path(creator.user_id)
    else
      link_to image_tag('/img/mobu.png', class: appearance),
      creator_path(creator.user_id)
    end
  end
  
  def noti(info)
    redirect_to request.referer, notice: info
  end
  
  def alt(info)
    redirect_to request.referer, alert: info
  end
end
