Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :subjects, only: [:index]
      resources :questions, only: [:index] do
        collection do
          get 'filter'
        end
      end
    end
  end
end
