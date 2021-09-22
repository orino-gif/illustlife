module HomeHelper
  def display_character()
    p link_to image_tag('/img/mobu.png',class: 'icon'), "/creators/#{creator.user_id}"
  end
end
