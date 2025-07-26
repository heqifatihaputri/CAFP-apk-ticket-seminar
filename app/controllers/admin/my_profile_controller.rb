# frozen_string_literal: true

class Admin::MyProfileController < Admin::BaseAdminController
  before_action :set_breadcrumb

  def index
    @name_page = 'My Profile'
  end

  def update
    if current_admin.update(admin_params)
      flash[:notice] = "Profile changed successfully!"
    else
      flash[:alert] = current_admin.errors.full_messages.to_sentence
    end

    redirect_to admin_my_profile_index_path
  end

  private

  def set_breadcrumb
    default_breadcrumb
    breadcrumb 'My Profile', :admin_my_profile_index_path
  end

  def admin_params
    params.require(:admin).permit(:email, :name)
  end
end
