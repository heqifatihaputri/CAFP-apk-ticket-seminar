class User::Devise::SessionsController < Devise::SessionsController
  layout 'signed_out_layout'

  def new
    if admin_signed_in?
      flash[:alert] = "You're already signed in as an Admin!"
      redirect_to admin_root_path and return
    end
    super
  end

  def after_sign_in_path_for(resource)
    user_root_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    root_path
  end
end
