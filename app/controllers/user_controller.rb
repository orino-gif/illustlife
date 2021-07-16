class UserController < ApplicationController
  
  def index
  end

  def new
    @user = User.new
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
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)

      @user = current_user
      @url = request.url
      NotificationMailer.user_update(@user, @url).deliver
      redirect_to(user_path(@user))
    else
      render :new
    end
  end
end