Rails.application.routes.draw do

  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :objectifs do
        resources :krs
      end
    end
  end

end
