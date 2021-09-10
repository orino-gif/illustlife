module CreatorsHelper
  def display_nickname(name)
      "ニックネーム：#{name}"
  end
  
  def display_image(image_name)

   if @creator.deforume1?
        image_tag @creator.deforume1.url, class: 'thumbnail' 
   else 
        image_tag '/img/noImage.png', class: 'thumbnail cover' 
   end 
  end
end
