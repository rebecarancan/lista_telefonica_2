Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "contacts#index"

  get "/contacts", to: "contacts#index"
  post "/contacts", to: "contacts#create"
  get "/contacts/new", to: "contacts#new", as: "new_contact"
  get "/contacts/:id", to: "contacts#show", as: "contact"
  get "contacts/:id/edit", to: "contacts#edit", as: "edit_contact"
  patch "contacts/:id", to: "contacts#update"
  delete "contacts/:id", to: "contacts#destroy"
end
