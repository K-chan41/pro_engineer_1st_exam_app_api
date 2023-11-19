Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :subjects, only: [:index]
      resource :authentication, only: [:create, :destroy]
      resources :registrations, only: [:create, :destroy]
      resources :questions, only: [:index] do
        collection do
          get 'filter'
        end
      end
    end
  end
end
