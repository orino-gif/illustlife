class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable,
         :omniauthable, omniauth_providers: [:twitter] # ,:validatable,
         
  soft_deletable # <- kakurenbo-putiを使えるようにする
         
  # Twitter認証ログイン用
  # ユーザーの情報があれば探し、無ければ作成する       
  # omniauthのコールバック時に呼ばれるメソッド
  def self.from_omniauth(auth, new_record)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.id = auth.id
      user.created_at = DateTime.now
      user.updated_at = DateTime.now
      user.agree = true
      user.nick = auth.info.nick
      user.confirmed_at = DateTime.now
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20] # ランダムなパスワードを作成
      new_record[0] = true
    end
  end
  
  validates :agree, presence: {message: ':利用規約にチェックを入力してください'}

  # 論理削除に対応するため、validationをカスタマイズする
  validates :email, presence: true, length: { maximum: 255 }
  validates_uniqueness_of :email, scope: :soft_destroyed_at
  validates_format_of :email, with: Devise.email_regexp,
    if: :will_save_change_to_email?
  validates :password, presence: true, confirmation: true,
    length: { in: Devise.password_length }, on: :create
  validates :password, confirmation: true,
    length: { in: Devise.password_length }, allow_blank: true, on: :update
  
  # データベース認証時に使われるメソッドを上書きして、
  # without_soft_destroyedを追加する
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    self.without_soft_destroyed.where(conditions.to_h).first
  end
         
  #dependent: :destroyは、userレコードの削除に伴って生成したレコードを削除するコード。
  has_one :creator , dependent: :destroy
  has_one :credit , dependent: :destroy
  # has_one :card, dependent: :destroy
end
