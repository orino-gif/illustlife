module CreatorsHelper
  def display_header(creator)
    if creator.header?
      image_tag creator.header.url, class: 'size-header fit-cover'
    else
      image_tag '/img/nothing.png', class: 'size-header fit-cover'
    end
  end
end
