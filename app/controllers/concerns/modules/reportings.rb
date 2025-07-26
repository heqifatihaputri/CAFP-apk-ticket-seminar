# frozen_string_literal: true

module Modules
  module Reportings
    extend ActiveSupport::Concern
    
    included do
      before_action :get_export_data, only: :export_report

      def get_export_data
        return if params[:date_range].blank?

        @file_name = "#{params[:report_option]} (#{params[:date_range]})"
        split_date = params[:date_range].split(" - ")
        start_date = Date.strptime(split_date.first, '%d/%m/%Y')
        end_date   = Date.strptime(split_date.last, '%d/%m/%Y')+1

        case params[:report_option]
        when 'user_list'
          params_q = { created_at_gteq: start_date, created_at_lteq: end_date }
          @q       = User.ransack(params_q)
          @data    = @q.result.order_by_created_at.order_by_name
        when 'event_ticket_stock'
          params_q = { start_time_gteq: start_date, start_time_lteq: end_date }
          @q    = Event.ransack(params[:q])
          @data = @q.result.order_start_time
        when 'sales_invoices'
          params_q = { paydate_gteq: start_date, paydate_lteq: end_date }
          @q       = Invoice.success.ransack(params[:q])
          @data    = @q.result.order_by_payment_date
        end
      end
    end
  end
end
