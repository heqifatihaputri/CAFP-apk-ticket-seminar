# frozen_string_literal: true

class User::BaseController < ApplicationController
  # include Pundit

  before_action :authenticate_user!
  layout 'application_user'

  # before_action :set_authorize
  # before_action :set_cart_items

  # rescue_from Pundit::NotDefinedError, with: :user_not_authorized

  private

  def set_cart_items
    @user_cart_items = if current_user.present?
                         current_user.cart.try(:cart_items) || []
                       else
                         []
                       end
  end

  def set_authorize
    UserPolicy::Scope.new(current_user, User).resolve(params[:action], params[:controller])
  end

  def user_not_authorized
    case current_user.error_message_pundit
    when :set_authorize_membership
      flash[:alert] = 'Your membership expired select new membership renewal'
      redirect_to(user_subscriptions_path) and return
    when :set_authorize_ticket_attendee
      flash[:alert] = 'Please update your ticket attendee info!'
      redirect_to edit_ticket_attendees_user_tickets_path and return
    end
  end
end
