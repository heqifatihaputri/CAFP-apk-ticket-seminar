# frozen_string_literal: true

class Admin::ReportingsController < Admin::BaseAdminController
  include Modules::Reportings

  before_action :get_options, only: :index

  def get_options
    @select_options = ["User List", "Event & Ticket Stock", "Sales Invoices"].
                      map{ |option| [option, option.parameterize.underscore] }
  end

  def export_report
    respond_to do |format|
      format.html { }
      format.xlsx { render xlsx: params[:report_option], filename: "#{@file_name}.xlsx" }
    end
  end
end
