class MypagesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, success: t("defaults.flash_message.updated", item: "ユーザー情報")
    else
      flash.now["danger"] = t("defaults.flash_message.not_updated", item: "ユーザー情報")
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:nick_name, :email, :user_icon, :user_icon_cache)
  end
end
