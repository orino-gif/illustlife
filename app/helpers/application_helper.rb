module ApplicationHelper
  def display_icon(creator, appearance)
    if creator.icon?
      if (controller.controller_name == 'homes') && (controller.action_name == 'index')
        link_to image_tag(creator.icon.url, class: appearance), creator_path(creator.user_id)
      else
        image_tag creator.icon.url, class: appearance
      end
    else
      if (controller.controller_name == 'homes') && (controller.action_name == 'index')
        link_to image_tag('/img/mobu.png', class: appearance), creator_path(creator.user_id)
      else
        image_tag '/img/mobu.png', class: appearance
      end
    end
  end
end
