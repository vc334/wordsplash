Rails.application.routes.draw do
  devise_for :users
  root to: 'words#new'
  get 'settings', to: 'words#settings'
  get 'settingssecond', to: 'words#settingssecond'

  resources :words do
    collection do
      get :flashcards
      post 'flashcards_second'
      get :show_second
      get :practice
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
