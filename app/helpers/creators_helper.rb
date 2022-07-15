module CreatorsHelper
  def display_header(creator, appearance)
    if creator.header?
      image_tag creator.header.url, class:appearance
    else
      image_tag '/img/nothing.png', class:appearance
    end
  end
end
