Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :user_question_relations, only: [:index, :create]
      resources :flags, only: [:index, :create, :destroy]
      get 'user_info', to: 'users#show'
      resources :subjects, only: [:index]
      resource :authentication, only: [:create, :destroy]
      resource :registration, only: [:create, :destroy]
      resources :questions, only: [:index] do
        collection do
          get 'filter'
          get 'shuffle'
        end
      end
    end
  end
end
