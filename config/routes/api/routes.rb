module Api::Routes
  def self.extended(router)
    router.instance_exec do
      namespace :api, defaults: { format: :json } do
        resources :ticket_sessions, only: :index do
          collection do
            post :scan_in
            put  :scan_out
            get  :get_ticket_alert
          end
        end
      end
    end
  end
end
