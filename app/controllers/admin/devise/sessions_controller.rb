class Admin::Devise::SessionsController < Devise::SessionsController
  layout 'signed_out_layout'

  def new
    if user_signed_in?
      flash[:alert] = "You're already signed in as an User!"
      redirect_to user_root_path and return
    end
    super
  end

  def after_sign_in_path_for(resource)
    admin_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_url
  end
end
