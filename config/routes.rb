Rails.application.routes.draw do
  mount AttachmentUploader.upload_endpoint(:cache) => "/images/upload"

  devise_for :admins, controllers: {
    sessions: 'admin/devise/sessions'
  }

  devise_for :users, controllers: {
    passwords: 'user/devise/passwords',
    registrations: 'user/devise/registrations',
    sessions: 'user/devise/sessions'
  }

  # landing page
  get 'public_page/landing_page', as: 'landing_page'
  root 'public_page#landing_page'

  # public page
  get 'events/:event_id' => 'public_page#show_event', as: 'show-events'
  get 'scan_physical_ticket/events/:event_id/link/:link_token' => 'public_page#scan_physical_ticket', as: 'scan_physical_ticket'
  get 'page_not_found' => 'public_page#page_not_found', as: 'page_not_found'
  get 'print_certification/:ticket_id' => 'public_page#print_certification', as: 'print_certification'

  resources :tickets, only: [] do
    resources :certification, only: [:index]
  end

  extend UserRoutes
  extend AdminRoutes
  extend Api::Routes
end
