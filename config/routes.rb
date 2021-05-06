Rails.application.routes.draw do

  root to: 'home#index'

  namespace :api do
    namespace :v1 do
      resources :objectifs, defaults: { format: 'json' } do

        get 'process_weight', on: :collection
        get 'process_weight' => 'krs#process_weight'

        resources :krs, only: ['update', 'destroy', 'create'], defaults: { format: 'json' }
      end
    end
  end

end
