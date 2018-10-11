require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/csv_importer', to: 'csv_importer#index'
  post '/csv_importer', to: 'csv_importer#upload'
  get '/product_stats', to: 'product_stats#index'
  post '/product_stats', to: 'product_stats#search'
  get '/product_stats/:product_id', to: 'product_stats#show'
  mount Sidekiq::Web, :at => "/sidekiq"
end
