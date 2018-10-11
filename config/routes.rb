Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/csv_importer', to: 'csv_importer#index'
  post '/csv_importer', to: 'csv_importer#upload'
end
