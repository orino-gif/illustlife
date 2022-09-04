# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    begin
      super
      resource.build_creator
      resource.build_credit
      resource.save
      
    rescue => e
      p e
      if e.to_s.include?('Duplicate')
        flash.now[:alert] = "既に登録されているメールアドレスです" 
        
      elsif e.to_s.include?('attribute')
        flash.now[:alert] = "レコード生成時に不明なカラムを検知しました" 
      else
        flash.now[:alert] = "ユーザー登録に失敗しました" 
      end
      render :new
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end
  
  # DELETE /resource
  def destroy
    resource.soft_destroy # <- 論理削除を実行
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end
  
  
  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  
  #ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    redirect_to(creator_path(@user))
  end
  
  #ユーザー情報変更後のリダイレクト先
  def after_update_path_for(resource)
      creator_path(@user)
  end
  
  # パスワード入力無しで更新
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
