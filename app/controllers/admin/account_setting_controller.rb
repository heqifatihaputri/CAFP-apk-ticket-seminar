# frozen_string_literal: true

class Admin::AccountSettingController < Admin::BaseAdminController
  before_action :set_breadcrumb
  before_action :get_admin, only: [:update]

  def index
    @name_page = 'Account Setting'
  end

  def update
    if @admin.valid_password?(params[:admin][:current_password])
      if @admin.update(admin_params)
        sign_out current_admin
        sign_in(:admin, @admin)
        flash[:notice] = "Password changed successfully!"
      else
        flash[:alert] = @admin.errors.full_messages.to_sentence
      end
    else
      flash[:alert] = "Invalid current password!"
    end

    redirect_to admin_account_setting_index_path
  end

  private

  def set_breadcrumb
    default_breadcrumb
    breadcrumb 'Account Setting', :admin_account_setting_index_path
  end

  def get_admin
    @admin = current_admin
  end

  def admin_params
    params.require(:admin).permit(:password, :password_confirmation)
  end
end
