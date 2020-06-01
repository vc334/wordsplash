Rails.application.routes.draw do
  devise_for :users
  root to: 'words#new'

  resources :words do
    collection do
      get :flashcards
      post 'flashcards_second'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
