module AdminRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :admin do
        root 'dashboard#index'

        resources :account_setting, only: [:index, :update]
        resources :my_profile, only: [:index, :update]
        resources :users
        resources :venues
        resources :events do
          resources :ticket_stocks, except: [:index]
          resources :tickets, only: [:index] do
          end
          resources :event_sessions, except: [:index] do
            member do
              get :all_ticket_sessions
              get 'scan_out/:ticket_session_id' => 'event_sessions#scan_out', as: 'scan_out_ticket_session'
            end
          end
        end
        resources :balances, only: [] do
          member do
            get  :top_up_wallet
            post :create_balance_in
          end
        end
        resources :orders, only: [:index, :show]
        resources :reportings, only: [:index] do
          collection do
            get :export_report
          end
        end
      end
    end
  end
end
