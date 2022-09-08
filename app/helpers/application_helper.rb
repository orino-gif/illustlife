module ApplicationHelper
  # アイコンを表示。
  def display_icon(creator, appearance)
    if creator.icon?
      link_to image_tag(creator.icon.url, class: appearance),
        creator_path(creator.user_id)
    else
      link_to image_tag('/img/mobu.png', class: appearance),
        creator_path(creator.user_id)
    end
  end
end
