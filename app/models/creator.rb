class Creator < ApplicationRecord
    mount_uploader :image1, AvatarUploader
    mount_uploader :image2, AvatarUploader
    belongs_to :user
end

