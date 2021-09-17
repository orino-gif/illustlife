module CreatorsHelper

  def display_image(creator)
    if creator == @creator.deforume1 && @creator.deforume1?
      image_tag @creator.deforume1.url, class: 'thumbnail'
    elsif creator == @creator.deforume2 && @creator.deforume2?
      image_tag @creator.deforume2.url, class: 'thumbnail'
    elsif creator == @creator.deforume3 && @creator.deforume3?
      image_tag @creator.deforume3.url, class: 'thumbnail'
    else
      image_tag '/img/noImage.png', class: 'thumbnail cover'
    end
  end
end
