class Api::ApplicationSerializer < ActiveModel::Serializer
  include ApplicationHelper

  def message
    @instance_options[:message]
  end

  def pagination(data = {})
    kaminari            = @instance_options[:kaminari]
    data[:current_page] = kaminari.current_page
    data[:next_page]    = kaminari.next_page
    data[:prev_page]    = kaminari.prev_page
    data[:first_page?]  = kaminari.first_page?
    data[:last_page?]   = kaminari.last_page?
    data[:total_pages]  = kaminari.total_pages

    return data
  end
end