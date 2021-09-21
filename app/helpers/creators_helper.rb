module CreatorsHelper

  def display_image(creator)
    if creator == @creator.fg1 && @creator.fg1?
      image_tag @creator.fg1.url, class: 'thumbnail'
    elsif creator == @creator.fg2 && @creator.fg2?
      image_tag @creator.fg2.url, class: 'thumbnail'
    elsif creator == @creator.fg3 && @creator.fg3?
      image_tag @creator.fg3.url, class: 'thumbnail'
    else
      image_tag '/img/noImage.png', class: 'thumbnail cover'
    end
  end
end
