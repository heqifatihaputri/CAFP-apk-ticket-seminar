module ApplicationHelper
  def flash_message
    tag.div(class: 'flash-messages') do
      flash.map do |key, value|
        tag.div(class: "alert alert-dismissible fade show #{key == 'notice' ? 'alert-success' : 'alert-danger'}") do
          tag.button('', class: "btn-close", 'data-bs-dismiss' => 'alert') + value
        end
      end.join.html_safe
    end
  end

  def date_formater(date_data = nil, date_format = '%d/%m/%Y')
    '' if !date_data.respond_to?(:to_date) || date_data.blank?

    begin
      date_data.strftime(date_format)
    rescue StandardError
      nil
    end
  end

  def get_image_url(obj, version = :small)
    return "placeholder.jpg" if obj.blank?
    return obj.image_url(version) if obj.image_url(version).present?
    return obj.image_url || ""
  end

  def get_avatar_url(obj, version = :small)
    return "placeholder.jpg" if obj.blank?
    return obj.avatar_url(version) if obj.avatar_url(version).present?
    return obj.avatar_url || ""
  end

  def class_active(controller_params, active_path)
    controller_params.include?(active_path) ? 'nav-link' : 'nav-link collapsed'
  end

  def datetime_formater(date_data = nil, date_format = '%d/%m/%Y %I:%M %p')
    '' if !date_data.respond_to?(:to_date) || date_data.blank?

    begin
      date_data.strftime(date_format)
    rescue StandardError
      nil
    end
  end

  def build_select_options(objects, columns = {})
    data  = []
    label_n = columns[:label] || get_label(objects)
    value_n = columns[:value] || :id

    if objects.present?
      objects.each do |object|
        # set select option label
        label = label_n.map { |lbl| object.send(lbl).to_s }.join(' - ')
        # set select option value
        value = object.send(value_n)

        data << [label, value]
      end
    end

    data
  end

  def get_label(objects)
    return [] if objects.blank?
    case objects.klass.name
    when 'Country' # for nationalities please custom columns params
      ['country_name']
    else
      ['name'] 
    end
  end

  def ticket_name(item)
    item.ticket_stock.name
  end

  def event_name(item)
    item.event.name
  end

  def money_format(amount)
    number_to_currency(amount, unit: 'Rp ')
  end

  def order_status(order = nil, badge = true)
    return "-" if order.blank?
    if order.success?
      badge_class = "badge_active"
    else
      badge_class = "badge_active4"
    end
    label = order.status.try(:titleize)
    label = "Paid By e-Wallet Balance" if order.paid_with_balance? #&& !order.refund?

    if badge
      return "<div class=#{badge_class}>#{label}</div>".html_safe
    else
      return label
    end
  end

  def item_price(item)
    item.free_item? ? "<span style='color: red;'><b> Free </b></span>".html_safe : number_to_currency(item.price, unit: 'Rp ', precision: 2)
  end

  def payment_status(invoice, badge = true)
    return "-" if invoice.blank?
    order = invoice.order

    if invoice.success? || 
      badge_class = "badge_active"
    else
      badge_class = "badge_active4"
    end

    if order.paid_with_balance?
      label = "e-Wallet Balance"
    else
      label = order.status
    end

    if badge
      return "<div class=#{badge_class}>#{label}</div>".html_safe
    else
      return label
    end
  end

  def seo_meta_tag_url(content_url)
    default_web_url = Rails.application.secrets.default_web_url || "http://localhost:3000/"
    return content_url.present? ? "#{default_web_url}#{content_url}" : default_web_url
  end

  def copy_link_ticket(id, ticket)
    "<a class='btn btn-outline-primary mb-2 copy-link-ticket' data-id='#{id}' data-link='#{ticket}'>Copy Link</a> <br>
    <div class='copy-section-ticket copy-link-section-ticket-#{id}' style='display: none;'>
      <input type='text' name='link' id='clipboard-link-#{id}' value='Ticket-#{id}' class='form-control' readonly='readonly' style='100%''>
      <input type='text' name='link-#{id}' id='link-stream-#{id}' value='#{ticket}'>
    </div>".html_safe
  end
end
