class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  # request password reset.
  # you get here when the user entered their email in the reset password form and submitted it.
  def create
    @user = User.find_by(email: params[:email])
    # This line sends an email to the user with instructions on how to reset their password (a url with a random token)
    @user&.deliver_reset_password_instructions!
    # Tell the user instructions have been sent whether or not email was found.
    # This is to not leak information to attackers about which emails exist in the system.
    redirect_to login_path, success: t(".success")
  end

  # This is the reset password form.
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    not_authenticated if @user.blank?
  end

  # This action fires when the user has sent the reset password form.
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?

    # the next line makes the password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]
    # the next line clears the temporary token and updates the password
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: t(".success")
    else
      flash.now[:danger] = t(".fail")
      render :edit, status: :unprocessable_entity
    end
  end
end
