Rails.application.routes.draw do

  resources :shortened_urls

  get '/:id' => 'shortened_urls#show_shortened_url'

  root to: 'shortened_urls#new'
end
