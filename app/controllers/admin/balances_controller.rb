# frozen_string_literal: true

class Admin::BalancesController < Admin::BaseAdminController
  before_action :get_balance, only: [:top_up_wallet, :create_balance_in]

  def top_up_wallet;end

  def create_balance_in
    if @balance.balance_in(params[:amount].to_f, current_admin)
      flash[:notice] = "E-wallet Top Up Successfully!"
    else
      flash[:alert]  = "Something went wrong. Failed to top up e-wallet!"
    end
    redirect_to admin_user_path(@balance.user, tab: "e-wallet")
  end

  private

  def get_balance
    @balance = Balance.find(params[:id])
  end
end