# frozen_string_literal: true

class User::MyProfileController < User::BaseController
  before_action :set_breadcrumb
  before_action :get_form_collection, only: [:index]

  def index
    @name_page = 'My Profile'
    @user_profile = current_user.user_profile
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "Profile changed successfully!"
    else
      flash[:alert] = current_user.errors.full_messages.to_sentence
    end

    redirect_to user_my_profile_index_path
  end

  private

  def set_breadcrumb
    default_breadcrumb
    breadcrumb 'My Profile', :user_my_profile_index_path
  end

  def get_form_collection
    @genders   = UserProfile.genders.map{|key_, a| [key_.titleize, key_]}
    @countries = build_select_options(Country.all)
    @marital_statuses = UserProfile.marital_statuses.map{|key_, a| [key_.titleize, key_]}
  end

  def user_params
    params.require(:user).permit(:email, user_profile_attributes: [ :id, :user_uid, :full_name, :nric, :dob, :gender,
                                         :marital_status, :company, :job, :avatar_data, :city, :postcode, :address,
                                         :mobile_phone, :home_number, :facebook, :instagram, :linkedin, :user_id, :country_id, :avatar])
  end
end
