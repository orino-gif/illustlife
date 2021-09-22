module HomeHelper
  def display_img(creator)
    if creator.icon?
      link_to image_tag(creator.icon.url, class: 'icon center-block'), "/creators/#{creator.user_id}" 
    else
     link_to image_tag('/img/mobu.png', class: 'icon center-block'), "/creators/#{creator.user_id}" 
    end
  end
end
