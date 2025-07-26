class Cart < ApplicationRecord
  belongs_to :user

  has_many   :cart_items, dependent: :destroy

  before_create :check_user

  accepts_nested_attributes_for :cart_items, allow_destroy: true

  def check_user
    carts = Cart.where(user_id: self.user_id).where.not(user_id: nil)
    if carts.present?
      self.id = carts.first.id
    end
  end

  def build_cart_item_param(params)
    item_collect = params[:cart][:cart_items_attributes].permit!.to_h.map do |idx, detail|
      next if detail[:quantity].to_i < 1 && params[:add_individual].blank?

      cart_items.add_to_cart_item(detail)
    end.compact

    item_result = item_collect.map do |item|
      item.errors.blank? ? item.valid? : false
    end

    if item_result.include?(false) || item_result.blank?
      full_messages = item_collect.map { |e| e.errors.full_messages }.flatten
      full_messages += ['Something went wrong'] if full_messages.blank?

      full_messages
    else
      item_collect.each do |e|
        e.save
      end

      true
    end
  end
end
