module CreatorsHelper
  def display_header(creator, appearance)
    if 'homes' == controller.controller_name
      if creator.header?
        link_to image_tag(creator.header.url, class: appearance), creator_path(creator.user_id)
      else
        link_to image_tag('/img/nothing.png', class: appearance), creator_path(creator.user_id)
      end
    else
      if creator.header?
        image_tag creator.header.url, class: appearance
      else
        image_tag '/img/nothing.png', class: appearance
      end
    end
  end
end
