module CreatorsHelper

  def show_fg(creator)
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
  
  def show_bg(creator)
    if creator == @creator.bg1 && @creator.bg1?
      image_tag @creator.bg1.url, class: 'thumbnail'
    elsif creator == @creator.bg2 && @creator.bg2?
      image_tag @creator.bg2.url, class: 'thumbnail'
    elsif creator == @creator.bg3 && @creator.bg3?
      image_tag @creator.bg3.url, class: 'thumbnail'
    else
      image_tag '/img/noImage.png', class: 'thumbnail cover'
    end
  end
  
  def show_cg(creator)
    if creator == @creator.cg1 && @creator.cg1?
      image_tag @creator.cg1.url, class: 'thumbnail'
    elsif creator == @creator.cg2 && @creator.cg2?
      image_tag @creator.cg2.url, class: 'thumbnail'
    elsif creator == @creator.cg3 && @creator.cg3?
      image_tag @creator.cg3.url, class: 'thumbnail'
    else
      image_tag '/img/noImage.png', class: 'thumbnail cover'
    end
  end
end
