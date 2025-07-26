# frozen_string_literal: true

class User::AccountSettingController < User::BaseController
  before_action :set_breadcrumb
  before_action :get_user, only: [:update]

  def index
    @name_page = 'Account Setting'
  end

  def update
    if @user.valid_password?(params[:user][:current_password])
      if @user.update(user_params)
        sign_out current_user
        sign_in(:user, @user)
        flash[:notice] = "Password changed successfully!"
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
      end
    else
      flash[:alert] = "Invalid current password!"
    end

    redirect_to user_account_setting_index_path
  end

  private

  def set_breadcrumb
    default_breadcrumb
    breadcrumb 'Account Setting', :user_account_setting_index_path
  end

  def get_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
