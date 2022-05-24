class Credit < ApplicationRecord
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
  validates :account_number, length: { minimum: 1, maximum: 8 }
end
