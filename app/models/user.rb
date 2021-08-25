class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
  #dependent: :destroyを付与してuserレコードの削除に伴ってcreatorレコードを削除。
  has_one :creator #, dependent: :destroy 
 
end
