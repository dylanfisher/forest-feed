Rails.application.routes.draw do
  # Admin
  namespace :admin do
    namespace :forest do
      namespace :feed do
        resources :instagram_post, except: [:show, :new] do
          post 'sync', on: :collection
        end
        resources :tokens
      end
    end
  end
end
