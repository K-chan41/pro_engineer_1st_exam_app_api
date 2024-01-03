Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :flags, only: [:create, :destroy]
      get 'user_info', to: 'users#show'
      resources :subjects, only: [:index]
      resource :authentication, only: [:create, :destroy]
      resource :registration, only: [:create, :destroy]
      resources :questions, only: [:index] do
        collection do
          get 'filter'
        end
      end
    end
  end
end
