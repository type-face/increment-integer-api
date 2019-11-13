# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :v1 do
    get '/current', to: 'incrementer#show'
    patch '/current', to: 'incrementer#update'
    patch '/increment', to: 'incrementer#increment'
  end
end
