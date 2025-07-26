class Venue < ApplicationRecord
  belongs_to :country

  has_many   :events

  before_destroy :check_event

  scope :order_by_name, -> { order(name: :asc) }

  def check_event
    if events.present?
      self.errors.add(:base, "You don't allowed to delete this venue!")
      throw(:abort)
    end
  end
end
