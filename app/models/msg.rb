class Msg < ApplicationRecord
  belongs_to :expor, optional: true #optional:trueは外部キーを許可する設定
end
