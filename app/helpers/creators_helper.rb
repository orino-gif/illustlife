module CreatorsHelper
  # ヘッダーを表示。homeコントローラーの場合は、画像にリンク先を付与
  def display_header(creator, appearance)
    if 'homes' == controller.controller_name
      
      # creator.headerの値がNULLなら代替の画像を表示
      if creator.header?
        link_to image_tag(creator.header.url, class: appearance),
          creator_path(creator.user_id)
          
      else
        link_to image_tag('/img/nothing.png', class: appearance),
          creator_path(creator.user_id)
      end
      
    else
      if creator.header?
        image_tag creator.header.url, class: appearance
      else
        image_tag '/img/nothing.png', class: appearance
      end
    end
  end
  
  # クリエーターのリンク先が付与されたSNSアイコンを表示
  def display_sns(creator, sns)
    if creator.send(sns).present?
      link_to image_tag("/img/#{sns}.png",
        class: 'size_small-square position_short-top'), creator.send(sns)
    end
  end
end
