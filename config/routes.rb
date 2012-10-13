SpeakerVoice::Application.routes.draw do
  root to: 'pages#index'
  resource :page, only: [:show]

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'
end
