class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t("users.create.success")
    else
      flash.now[:failure] = t("users.create.failure")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:nick_name, :email, :password, :password_confirmation, :user_icon, :user_icon_cache)
  end
end
