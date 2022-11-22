module CresHelper
  # ヘッダーを表示。homeコントローラーの場合は、画像にリンク先を付与
  def disp_hdr(cre, scss)
    if 'homes' == controller.controller_name
      if cre.hdr?
        link_to image_tag(cre.hdr.url, class: scss),
        cre_path(cre.user_id)
      else
        link_to image_tag('/img/nothing.png', class: scss),
        cre_path(cre.user_id)
      end
    else
      if cre.hdr?
        image_tag cre.hdr.url, class: scss
      else
        image_tag '/img/nothing.png', class: scss
      end
    end
  end
  
  # クリエーターのリンク先が付与されたSNSアイコンを表示
  def disp_sns(cre, sns)
    if cre.send(sns).present?
      link_to image_tag("/img/#{sns}.png", class: 's_square s_top-pos'),
      cre.send(sns)
    end
  end
end
