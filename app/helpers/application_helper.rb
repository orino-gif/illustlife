module ApplicationHelper
  def display_character(creator)
    if creator.icon?
      if controller.controller_name == "home" && controller.action_name == 'index'
        link_to image_tag(creator.icon.url, class: 'icon center-block'), "/creators/#{creator.user_id}" 
      else
        
      end
    else
     link_to image_tag('/img/mobu.png', class: 'icon center-block'), "/creators/#{creator.user_id}" 
    end
  end
end
