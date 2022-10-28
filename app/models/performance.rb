class Performance < ApplicationRecord
  belongs_to :creator, optional: true #optional:trueは外部キーを許可する設定
end
