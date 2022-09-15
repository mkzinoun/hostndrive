Rails.application.routes.draw do
  resources :listings do
    resources :bookings, only: %i[index create destroy]
    resources :reservations, only: %i[create destroy]
  end
  resources :missions, only: [:index]
end
