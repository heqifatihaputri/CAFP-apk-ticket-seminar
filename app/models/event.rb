class Event < ApplicationRecord
  belongs_to :venue

  has_many   :ticket_stocks,    dependent: :destroy
  has_many   :event_sessions,   dependent: :destroy
  has_many   :tickets,          dependent: :destroy
  has_many   :ticket_sessions,  dependent: :destroy
  has_many   :images,           dependent: :destroy, as: :uploadable, class_name: "Image"

  validates_presence_of :name, :description

  accepts_nested_attributes_for :images, allow_destroy: true

  before_destroy :check_purchased_tickets

  scope :event_opened, -> { where(ticket_start_selling: true) }
  scope :order_start_time, -> { order(:start_time) }

  ransacker :start_time_filter do |parent|
    Arel.sql("date(start_time)")
  end

  def date_period
    "#{start_time.strftime('%d/%m/%Y %l:%M%p')} - #{end_time.strftime('%d/%m/%Y %l:%M%p')}"
  end

  def venue_location
    venue&.name || "-"
  end

  def is_started?
    return false if start_time.blank? || end_time.blank?
    return Time.zone.now.between?(start_time-60.minutes, end_time+120.minutes)
  end

  def is_ended?
    return false if end_time.blank?
    return Time.zone.now > end_time
  end

  def time_before_start
    time = (self.start_time - Time.zone.now)/60
    if time < 31
      time.to_i
    else
      0
    end
  end

  def go_to_platform_url
    if platform_url.include?("://")
      platform_url
    else
      "//"+platform_url
    end
  end

  def selling_status
    return "Ticket sales have not started" unless ticket_start_selling
    return "Yes, display it on the user page for sale"
  end

  def check_purchased_tickets
    if OrderItem.where(event: self).present?
      self.errors.add(:base, "You don't allowed to delete this event!")
      throw(:abort)
    end
  end

  def self.update_event_to_close
    events = Event.order(created_at: :DESC)

    events.each do |event|
      event.update(ticket_start_selling: false) if Time.zone.now >= event.end_time
    end
  end
end
