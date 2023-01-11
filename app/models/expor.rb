class Expor < ApplicationRecord
  has_many :ovrs , dependent: :destroy
  has_one :msg , dependent: :destroy
  mount_uploader :e_img, CreUploader
  
  validates :e_dl, presence: true
  validates :cmt, length: { maximum: 17 } , presence: true
  validates :gist, length: { maximum: 1000 }
  
  validates :e_dl, date: true
  
  validates :e_dl,  date: {
    # 本日から30日以内の範囲のみ許可する
    after_or_equal_to: ->(obj) { Date.today },
    before_or_equal_to: (Date.today+30)
  }
end
