class Admin::UsersController < Admin::BaseAdminController
  include Modules::Crudable

  before_action :get_form_collection, only: %i[index new create edit update]
  before_action :set_search, only: %i[index]
  before_action :set_breadcrumb

  self.additional_parameters = [
    user_profile_attributes: [ :id, :user_uid, :full_name, :nric, :dob, :gender, :marital_status, :company, :job, :avatar_data, :city, :postcode, :address, :mobile_phone, :home_number, :facebook, :instagram, :linkedin, :user_id, :country_id]
  ]


  def index
    @name_page = "User Data"
    @users     = @users.page(params[:page])
  end

  def create
    super do
      @user.generate_default_password
      @user_profile = @user.user_profile || @user.build_user_profile
    end
  end

  def new
    super do
      breadcrumb "New User", "#"

      @user_profile = @user.build_user_profile
    end
  end

  def edit
    super do
      breadcrumb "User Detail", admin_user_path(@user)
      breadcrumb "Edit User", "#"

      @user_profile = @user.user_profile
    end
  end

  def show
    super do
      @name_page = "User Detail"
      breadcrumb @name_page, admin_user_path(@user)

      @tab = params[:tab] || 'profile-overview'
      @profile = @user.user_profile
      @balance = @user.current_balance
    end
  end

  def set_search
    params[:q] ||= {}

    @q     = User.order_by_user_uid.ransack(params[:q])
    @users = @q.result
  end

  private

  def get_form_collection
    @genders   = UserProfile.genders.map{|key_, a| [key_.titleize, key_]}
    @countries = build_select_options(Country.all)
    @marital_statuses = UserProfile.marital_statuses.map{|key_, a| [key_.titleize, key_]}
  end

  def set_breadcrumb
    default_breadcrumb
    breadcrumb "User Data", :admin_users_path
  end
end
