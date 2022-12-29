class Expor < ApplicationRecord
  has_many :ovrs , dependent: :destroy
  has_one :msg , dependent: :destroy
  mount_uploader :e_img, CreUploader
end
