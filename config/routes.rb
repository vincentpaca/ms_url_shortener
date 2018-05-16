Rails.application.routes.draw do
  get 'shorten', action: :show, controller: 'shorten'

  root 'shorten#show'
end
