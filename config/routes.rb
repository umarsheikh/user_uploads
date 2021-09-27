Rails.application.routes.draw do
  get 'process_file/import'
  root to: 'process_file#import'

  post 'process_file/import'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
