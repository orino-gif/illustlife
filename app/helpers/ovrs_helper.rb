module OvrsHelper
  def ex_img(expor_id)
    expor = Expor.find_by(id: expor_id)
    if expor.e_img?
      send_data(expor.e_img.read, 
      filename: "download#{File.extname(expor.e_img.path)}")
    end
  end
end
