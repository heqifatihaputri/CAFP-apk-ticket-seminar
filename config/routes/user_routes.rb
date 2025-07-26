module UserRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :user do
        root :to => 'events#index'

        resources :account_setting, only: %i[index update]
        resources :my_profile, only: [:index, :update]
        resources :events, only: %i[index show] do
          member do
            get 'add_to_cart', to: 'events#cart_preview'
          end
        end
        resources :carts do
          collection do
            post :add_to_cart
            post :update_quantity
            get  :checkout
            get  :molpay_checkout
            get  :make_order_temp
            get  :update_price_cart_item
          end
        end
        resources :cart_items, only: :destroy do
          collection do
            delete :clear_all
          end
          member do
            post :plus
            post :minus
            get  :add_ticket_attendee
            put  :update_ticket_attendee
            get  :attendee_info_option
          end
        end
        resources :orders, only: %i[index show] do
          collection do
            # post :molpay_ipn
          end
        end
        resources :order_temps, only: %i[index show] do
          collection do
            # post :molpay_ipn
          end
        end
        resources :tickets, only: %i[index] do
          member do
            get :get_link
            get :edit_remark
            put :update_remark
            get 'link/:token', to: 'tickets#link', as: :link
          end
          collection do
            get 'details/:ticket_stock_id' => 'tickets#details', as: 'ticket_details'
          end
        end
      end
    end
  end
end
