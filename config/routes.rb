Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  #For API routes use get/to to redirect to the API controller
  scope '/api' do
    defaults format: :json do
      #GET method
      get '/curriculums', to: 'api_curriculums#index'
      get '/curriculums/:curriculum_id', to: 'api_curriculums#show'
      get '/curriculums/:curriculum_id/learning_units', to: 'api_learning_units#index'
      get '/curriculums/:curriculum_id/learning_units/:learning_unit_id', to: 'api_learning_units#show'
      get '/curriculums/:curriculum_id/learning_units/:learning_unit_id/resources', to: 'api_resources#index'
      get '/curriculums/:curriculum_id/learning_units/:learning_unit_id/resources/:resource_id', to: 'api_resources#show'
    end
  end

  resources :resources, only: %i[show] do
    resources :resource_comments, only: %i[create]
    resources :resource_evaluations, only: %i[create]
  end

  resources :curriculums, only: [:show] do
    resources :learning_units, only: [:index]
  end

  resources :learning_units, only: [:show] do
    resources :resources, only: %i[create]
    resources :completed_learning_units, only: %i[create destroy]
  end

  root 'curriculums#show'
end