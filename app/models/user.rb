class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,:omniauthable, omniauth_providers: %i[twitter]
         
         
  # omniauthのコールバック時に呼ばれるメソッド
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        image: auth.info.image,
        name: auth.info.name,
        nickname: auth.info.nickname,
        location: auth.info.location
      )
    end

    user
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
  
  validates :accepted, presence: {message: ':利用規約にチェックを入力してください'}
  validates :nickname, uniqueness: {message: ':重複したニックネームです'}
         
  #dependent: :destroyは、userレコードの削除に伴って生成したレコードを削除するコード。
  has_one :creator , dependent: :destroy 
  has_one :credit , dependent: :destroy 
end
