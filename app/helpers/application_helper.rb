module ApplicationHelper
  def display_icon(creator)
    if creator.icon?
      if controller.controller_name == "homes" && controller.action_name == 'index'
        link_to image_tag(creator.icon.url, class: 'icon center-block'), creator_path(creator.user_id)
      else
        image_tag creator.icon.url, class: 'icon center-block'
      end
    else
      if controller.controller_name == "homes" && controller.action_name == 'index'
        link_to image_tag('/img/mobu.png', class: 'icon center-block'), creator_path(creator.user_id)
      else
        image_tag '/img/mobu.png', class: 'icon center-block'
      end
    end
  end
end
