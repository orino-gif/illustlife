class Creator < ApplicationRecord
  mount_uploader :header, AvatarUploader
  belongs_to :user, optional: true
end

