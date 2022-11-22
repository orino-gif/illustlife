class Sttg < ApplicationRecord
  belongs_to :cre, optional: true
  # 推奨金額入力値が1000以上の数字のみ。空でないこと。
  validates :recom, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 1000}
  # 最小金額入力値が1000以上の数字のみ。空でないこと。
  validates :min, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 1000}
end
