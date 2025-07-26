class Admin::DashboardController < Admin::BaseAdminController
  def index
    @current_sales = Invoice.sales_by_month(Date.today)
    @prev_sales    = Invoice.sales_by_month(Date.today-1.month)

    increase = Invoice.sales_increase(@current_sales.count, @prev_sales.count)
    @sales_increase = increase.eql?("0%") ? nil : increase

    @current_revenue = @current_sales.sum(:total)
    @prev_revenue    = @prev_sales.sum(:total)

    increase = Invoice.sales_increase(@current_revenue, @prev_revenue)
    @revenue_increase = increase.eql?("0%") ? nil : increase

    @current_registered = User.registered_by_year(Date.today.year)
    @prev_registered    = User.registered_by_year(Date.today.year-1)

    increase = User.registered_increase(@current_registered.count, @prev_registered.count)
    @registered_increase = increase.eql?("0%") ? nil : increase

    @top_selling = TicketStock.top_selling
  end
end
