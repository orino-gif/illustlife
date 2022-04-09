class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,:omniauthable, omniauth_providers: [:twitter]
         
  # Twitter認証ログイン用
  # ユーザーの情報があれば探し、無ければ作成する       
  # omniauthのコールバック時に呼ばれるメソッド
  def self.from_omniauth(auth, new_record)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.id = auth.id
      user.created_at = DateTime.now
      user.updated_at = DateTime.now
      user.accepted = true
      user.nickname = auth.info.nickname
      user.confirmed_at = DateTime.now
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20] # ランダムなパスワードを作成
      new_record[0] = true
    end
  end
  
  validates :accepted, presence: {message: ':利用規約にチェックを入力してください'}
  validates :nickname, uniqueness: {message: ':重複したニックネームです'}
         
  #dependent: :destroyは、userレコードの削除に伴って生成したレコードを削除するコード。
  has_one :creator , dependent: :destroy 
  has_one :credit , dependent: :destroy 
end
