module ApplicationHelper
  def display_icon(creator, appearance)
    if creator.icon?
      if not ('creators' == controller.controller_name ) && (('show' == controller.action_name ) || ('edit' == controller.action_name))
        link_to image_tag(creator.icon.url, class: appearance), creator_path(creator.user_id)
      else
        image_tag creator.icon.url, class: appearance
      end
    else
      if not ('creators' == controller.controller_name ) && (('show' == controller.action_name ) || ('edit' == controller.action_name))
        link_to image_tag('/img/mobu.png', class: appearance), creator_path(creator.user_id)
      else
        image_tag '/img/mobu.png', class: appearance
      end
    end
  end
end
