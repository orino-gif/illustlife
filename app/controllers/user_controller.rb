class UserController < ApplicationController
  def new
    # ストロングパラメータから精査されたデータだけをインスタンスに格納
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = '新しいユーザーを登録しました。'
      @url = request.url + "/" + @user.id.to_s
      NotificationMailer.user_create(@user, @url).deliver
      redirect_to(user_path(@user))
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end

  def show
    if user_signed_in?
     @user = User.find(current_user.id)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      @user = current_user
      
      #現在のURLを取得
      @url = request.url
      
      NotificationMailer.user_update(@user, @url).deliver
      redirect_to(creator_path(@user))
    else
      render :new
    end
  end
  
  private

  def user_params
  end
end
