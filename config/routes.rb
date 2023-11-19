Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :subjects, only: [:index]
      resource :authentication, only: %i[create]
      resource :registration, only: %i[create]
      resources :questions, only: [:index] do
        collection do
          get 'filter'
        end
      end
    end
  end
end
