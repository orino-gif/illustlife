class Credit < ApplicationRecord
  belongs_to :user, optional: true # optional:trueは外部キーを許可する設定
  validates :number, length: { maximum: 8 }
end
