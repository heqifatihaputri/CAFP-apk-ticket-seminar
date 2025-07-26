require "application_responder"

class ApplicationController < ActionController::Base
  # self.responder = ApplicationResponder
  include ApplicationHelper
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :skip_devise_controller
  before_action :set_cors

  def set_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  rescue_from ActionController::Redirecting::UnsafeRedirectError do
    redirect_to page_not_found_path
  end

  # def after_sign_in_path_for(resource_or_scope)
  #   debugger
  #   if user_signed_in? && params[:user_id].blank? || current_user.id.eql?(params[:user_id].to_i)
  #     stored_location_for(resource_or_scope) #|| previous_url
  #   end
  # end

  def skip_devise_controller
    return if admin_signed_in?
    condition1 = !(params[:action].eql?("destroy"))
    condition2 = params[:action].eql?("landing_page") && (user_signed_in? || admin_signed_in?)

    if condition1 && condition2
      flash[:alert] = "You are already signed in."
      redirect_to default_root_path and return
    end
  end

  def default_breadcrumb
    breadcrumb 'Home', :root_path
  end

  def admin_dashboard_breadcrumb
    breadcrumb 'Dashboard', :admin_dashboard_path
  end

  protected

  def current_controller_path
    return @current_controller_path if @current_controller_path.present?

    splited_class_name = self.class.name.to_s.split('::')
    splited_class_name.delete(splited_class_name.last)
    @current_controller_path = splited_class_name.join('_').downcase
    return nil if @current_controller_path.blank?

    @current_controller_path
  end

  def default_root_path
    if user_signed_in?
      return user_root_path
    elsif admin_signed_in?
      return admin_root_path
    else
      return root_path
    end
  end

  # def previous_url(object: nil, custom_condition: false)
  #   back_url   = request.referer
  #   object   ||= model if defined?(model)
  #   if back_url.eql?(request.original_url) || back_url.blank? || custom_condition || params[:user_id]
  #     return polymorphic_url([current_controller_path.to_sym, object]) if object.present?

  #     default_root_path
  #   else
  #     back_url
  #   end
  # end

  private

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
