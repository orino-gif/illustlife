class Pfm < ApplicationRecord
  belongs_to :cre, optional: true #optional:trueは外部キーを許可する設定
end
