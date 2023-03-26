# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end
  def twitter
    callback_for(:twitter)
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end
 
  
  #private

  # 連携の為のコールバック関数
  def callback_for(provider)
    new_record = [false]
    @user = User.from_omniauth(request.env["omniauth.auth"],new_record)
    if true == new_record[0]
      resource.build_cre
      resource.build_cr
      resource.save
    end
    
    # persisted・・・ActiveRecord::Baseを継承
    # インスタンスがデータベースに保存されていればtrue。いなければfalse。
    # ユーザー情報が保存されている場合、
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
        
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
      @user.restore #ユーザーアカウントを復旧
      
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to request.referer, alert: 'twitter連携に失敗しました'
  end
  

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
