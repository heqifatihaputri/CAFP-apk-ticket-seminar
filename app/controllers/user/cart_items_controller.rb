# frozen_string_literal: true

class User::CartItemsController < User::BaseController
  before_action :get_cart_item, only: :destroy

  def destroy
    if @cart_item.destroy
      flash[:notice] = "Item deleted successfully."
    else
      flash[:alert] = "Something went wrong! Please try again later."
    end
    redirect_to user_carts_path
  end

  private

  def get_cart_item
    @cart_item = CartItem.find(params[:id])
  end
end
