module OvrsHelper
  def eo_img(expor_id, ovr_id)
    if ovr_id == 'NULL'
      expor = Expor.find_by(id: expor_id)
      if expor.e_img?
        send_data(expor.e_img.read, 
        filename: "download#{File.extname(expor.e_img.path)}")
      end
    else
      ovr = Ovr.find_by(id: ovr_id)
      if ovr.o_img?
        send_data(ovr.o_img.read, 
        filename: "download#{File.extname(ovr.o_img.path)}")
      end
    end
  end
end
