SpeakerVoice::Application.routes.draw do
  root to: 'pages#index'
  resource :page, only: [:show]
end
