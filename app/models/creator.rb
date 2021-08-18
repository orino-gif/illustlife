class Creator < ApplicationRecord
    #has_one_attached :image # 追記
    mount_uploader :image1, AvatarUploader
    mount_uploader :image2, AvatarUploader
end

