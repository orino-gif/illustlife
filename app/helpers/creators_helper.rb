module CreatorsHelper
  # ヘッダーを表示。homeコントローラーの場合は、画像にリンク先を付与
  def disp_hdr(creator, scss)
    if 'homes' == controller.controller_name
      if creator.hdr?
        link_to image_tag(creator.hdr.url, class: scss),
        creator_path(creator.user_id)
      else
        link_to image_tag('/img/nothing.png', class: scss),
        creator_path(creator.user_id)
      end
    else
      if creator.hdr?
        image_tag creator.hdr.url, class: scss
      else
        image_tag '/img/nothing.png', class: scss
      end
    end
  end
  
  # クリエーターのリンク先が付与されたSNSアイコンを表示
  def disp_sns(creator, sns)
    if creator.send(sns).present?
      link_to image_tag("/img/#{sns}.png", class: 's_square s_top-pos'),
      creator.send(sns)
    end
  end
  
end
