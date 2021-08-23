class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
         #dependent: :destroyを付与してuserレコードの削除に伴ってcreatorレコードが削除されるようにしました。
         has_one :creator, dependent: :destroy
 
end
