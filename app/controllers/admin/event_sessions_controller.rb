class Admin::EventSessionsController < Admin::BaseAdminController
  include Modules::Crudable

  before_action :get_event, :redirect_back, :set_redirect_path, :set_breadcrumb
  before_action :check_event_time, only: :edit
  before_action :set_search, only: :all_ticket_sessions
  # before_action :check_event_session, only: :scan_out_session

  self.resource_action += %w[all_ticket_sessions scan_out_ticket_session]

  def new
    super do
      breadcrumb "New Event Session", "#"
    end
  end

  def edit
    super do
      breadcrumb "Edit Event Session", "#"
    end
  end

  def scan_out_session
    @scan_out_session = TicketSession.find_by(id: params[:scan_out_id])
    @ticket_sessions  = @current_event_session.ticket_sessions.with_out_time.page(params[:page]).per(20)
  end

  def scan_out_all
    TicketSession.scan_out_all(@event)

    redirect_to admin_event_event_sessions_path(@event), notice: "All ticket sessions already scanned out"
  end

  def all_ticket_sessions
    @name_page = 'All Attendance Sessions'
    breadcrumb @name_page, all_ticket_sessions_admin_event_event_session_path(@event, @event_session)

    params[:q] ||= {}
    @ticket_sessions = @event_session.ticket_sessions.order(in_time: :desc, out_time: :asc)
    @ticket_sessions = @ticket_sessions.ransack(params[:q]).result.page(params[:page])
  end

  def scan_out
    ticket_session = TicketSession.find(params[:ticket_session_id])

    if ticket_session.update(out_time: DateTime.now)
      ticket_session.ticket.update(last_ticket_session_id: nil)
      flash[:notice] = 'Scan Out is Successfully!'
    else
      flash[:alert] = ticket_session.errors.full_messages.to_sentence
    end

    redirect_to all_ticket_sessions_admin_event_event_session_path(@event, ticket_session.event_session)
  end

  private

  def redirect_back
    redirect_to admin_events_path, alert: 'Event not found!' if @event.blank?
  end

  def check_event_time
    redirect_to admin_event_path(@event, tab: "event-session"), alert: "Event is ended, can't update event session!" if @event.is_ended?
  end

  def get_event
    @event = Event.find(params[:event_id]) rescue nil
  end

  def set_redirect_path
    self.redirect_path = admin_event_path(@event, tab: "event-session")
  end

  def set_breadcrumb
    default_breadcrumb
    breadcrumb "Event Data", :admin_events_path
    breadcrumb "Event Details", admin_event_path(@event, tab: "event-session")
  end

  def set_search
    params[:q] ||= {}

    @q = @event_session.ticket_sessions.ransack(params[:q])
    @ticket_sessions = @q.result.order(in_time: :desc, out_time: :desc)
  end

  # def check_event_session
  #   @current_event_session = EventSession.current_event_session(@event)
  #   return redirect_to admin_event_path(@event), alert: 'Current event session not found!' if @current_event_session.blank?
  # end
end
