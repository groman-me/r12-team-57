SpeakerVoice::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'

  resource :page, only: [:show]
  resources :users do
    resources :decks do
      resource :narration, only: [:create]
    end
  end

  root to: 'pages#index'
end
