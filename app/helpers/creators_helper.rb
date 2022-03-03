module CreatorsHelper
  def display_header(creator, appearance)
    if creator.header?
      image_tag creator.header.url, class:appearance
    else
      image_tag '/img/nothing.png', class:appearance
    end
  end
  
  def display_sns(creator_sns, place_img, appearance)
    if creator_sns.present?
      link_to image_tag(place_img, class:appearance), creator_sns
    else
      image_tag place_img, class:appearance + ' img_color-translucent'
    end
  end
end
