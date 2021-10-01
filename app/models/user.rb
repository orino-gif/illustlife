class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :accepted, presence: {message: ':利用規約にチェックを入力してください'}
         
  #dependent: :destroyを付与してuserレコードの削除に伴ってcreatorレコードを削除。
  has_one :creator , dependent: :destroy 
  has_one :credit , dependent: :destroy 
  has_one  :card,  dependent: :destroy
end
