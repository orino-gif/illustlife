module HomeHelper
  def display_character(creator)
    if creator.fg1?
     link_to image_tag(creator.fg1.url, class: 'icon center-block'), "/creators/#{creator.user_id}" 
    else
     link_to image_tag('/img/mobu.png', class: 'icon center-block'), "/creators/#{creator.user_id}" 
    end
  end
  
  def display_bg(creator)
    if creator.bg1?
     link_to image_tag(creator.bg1.url, class: 'bg center-block'), "/creators/#{creator.user_id}" 
    else
     link_to image_tag('/img/nothing.png', class: 'bg center-block'), "/creators/#{creator.user_id}" 
    end
  end
  
  def display_cg(creator)
    if creator.cg1?
     link_to image_tag(creator.cg1.url, class: 'cg center-block'), "/creators/#{creator.user_id}" 
    else
     link_to image_tag('/img/nothing.png', class: 'cg center-block'), "/creators/#{creator.user_id}" 
    end
  end
end
