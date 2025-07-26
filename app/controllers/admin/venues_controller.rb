class Admin::VenuesController < Admin::BaseAdminController
  include Modules::Crudable

  before_action :get_collection, only: %i[index new create edit update]
  before_action :set_search, only: %i[index]
  before_action :set_breadcrumb

  def index
    @name_page = "Venue Data"
    @venues    = @venues.page(params[:page])
  end

  def new
    super do
      breadcrumb "New Venue", "#"
    end
  end

  def edit
    super do
      breadcrumb "Venue Detail", admin_venue_path(@venue)
      breadcrumb "Edit Venue", "#"
    end
  end

  def show
    super do
      @name_page = "Venue Detail"
      breadcrumb @name_page, admin_venue_path(@venue)
    end
  end

  def set_search
    params[:q] ||= {}

    @q      = Venue.order_by_name.ransack(params[:q])
    @venues = @q.result
  end

  private

  def get_collection
    @countries = build_select_options(Country.all)
  end

  def set_breadcrumb
    default_breadcrumb
    breadcrumb "Venue Data", :admin_venues_path
  end
end
