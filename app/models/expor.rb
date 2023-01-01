class Expor < ApplicationRecord
  has_many :ovrs , dependent: :destroy
  has_one :msg , dependent: :destroy
  mount_uploader :e_img, CreUploader
  
  validates :e_dl, presence: true
  # validates :e_img, presence: true, if: :msg_id.present?

end
