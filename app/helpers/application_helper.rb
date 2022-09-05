module ApplicationHelper
  # アイコンを表示。showアクション以外はアイコンにリンク先を付与
  def display_icon(creator, appearance)
    if 'show' != controller.action_name
      
      # creator.iconの値がNULLなら代替の画像を表示
      if creator.icon?
        link_to image_tag(creator.icon.url, class: appearance),
          creator_path(creator.user_id)
      else
        link_to image_tag('/img/mobu.png', class: appearance),
          creator_path(creator.user_id)
      end
    
    else
      if creator.icon?
        image_tag creator.icon.url, class: appearance
      else
        image_tag '/img/mobu.png', class: appearance
      end
    end
  end
end
