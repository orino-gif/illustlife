class Creator < ApplicationRecord
    #has_one_attached :image # 追記
    mount_uploader :image1, AvatarUploader
    mount_uploader :image2, AvatarUploader
    belongs_to :user
    has_one_attached :image1
end

