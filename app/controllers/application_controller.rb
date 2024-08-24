class ApplicationController < ActionController::Base
  before_action :require_login
  add_flash_types :success, :failure

  private

  def not_authenticated
    redirect_to login_path, danger: t("defaults.flash_message.require_login")
  end
end
