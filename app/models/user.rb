class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :accepted, presence: {message: ':利用規約にチェックを入力してください'}
         
  #dependent: :destroyは、userレコードの削除に伴って生成したレコードを削除するコード。
  has_one :creator , dependent: :destroy 
  has_one :credit , dependent: :destroy 
end
