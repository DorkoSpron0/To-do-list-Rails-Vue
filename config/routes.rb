Rails.application.routes.draw do
  resources :tasks
  get 'tasks/:id', to:'tasks#show'
end
