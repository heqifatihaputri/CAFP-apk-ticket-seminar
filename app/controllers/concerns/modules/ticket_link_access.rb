module Modules
  module TicketLinkAccess
    extend ActiveSupport::Concern

    included do
      skip_before_action :authenticate_user!, only: %i[link]

      before_action :get_ticket_link, only: [:link]
      before_action :redirect_public_page, only: [:link]

      def link;end

      def redirect_public_page
        @event = @ticket.event

        unless @event.is_started? && @event.time_before_start < 31
          redirect_to show_events_path(@ticket.event, link_token: @ticket.link_token), allow_other_host: true and return
        else
          redirect_to scan_physical_ticket_path(@ticket.event, @ticket.link_token) and return
        end
      end

      private

      def get_ticket_link
        @ticket = Ticket.find_by(id: params[:id], link_token: params[:token])
        return redirect_to get_back_url, alert: 'Link not found! Please check the link properly.' if @ticket.blank?
      end

      def get_back_url
        return user_root_path if current_user.present?
        return admin_root_path if current_admin.present?
        return root_path
      end
    end
  end
end
