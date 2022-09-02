class Request < ApplicationRecord
  mount_uploader :deliver_img, CreatorUploader
  mount_uploader :deliver_img2, CreatorUploader
  mount_uploader :deliver_img3, CreatorUploader
  mount_uploader :deliver_img4, CreatorUploader
  mount_uploader :deliver_img5, CreatorUploader
  mount_uploader :deliver_img6, CreatorUploader

  validates :message, length: {maximum: 700}
end
