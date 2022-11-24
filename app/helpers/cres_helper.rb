module CresHelper
  # クリエーターのリンク先が付与されたSNSアイコンを表示
  def disp_sns(cre, sns)
    if cre.send(sns).present?
      link_to image_tag("/img/#{sns}.png", class: 's_square s_ta-pos'),
      cre.send(sns)
    end
  end
end
