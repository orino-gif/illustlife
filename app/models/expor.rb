class Expor < ApplicationRecord
  has_many :ovrs , dependent: :destroy
  mount_uploader :e_img, CreUploader
end
