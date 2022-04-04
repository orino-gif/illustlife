class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,:omniauthable, omniauth_providers: %i[twitter]
         
         
  # omniauthのコールバック時に呼ばれるメソッド
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
  
  validates :accepted, presence: {message: ':利用規約にチェックを入力してください'}
  validates :nickname, uniqueness: {message: ':重複したニックネームです'}
         
  #dependent: :destroyは、userレコードの削除に伴って生成したレコードを削除するコード。
  has_one :creator , dependent: :destroy 
  has_one :credit , dependent: :destroy 
end
