Rails.application.routes.draw do

  namespace :admin do
    resources :payload_match_rules
  end

  resources :routes do
    collection do
      get :add_config
      delete :remove_config
      get :add_config_rule
      delete :remove_config_rule
      post :apply_config_rule
      get :add_filter
      delete :remove_filter
      get :add_filter_rule
      post :apply_filter_rule
      delete :remove_filter_rule
      post :add_service
      post :add_service_list
      post :edit_configurator
      post :add_configurator
      post :preview_configurator
    end
  end

  get 'pipeline/prebuilt', :to => 'routes#prebuilt', :as => :prebuilt_routes
  post 'pipeline/prebuilder', :to => 'routes#apply_prebuilt', :as => :apply_prebuilt_routes

  get 'pipeline/:pipeline_name/dashboard', :as => 'pipeline_dashboard', :to => 'routes#dashboard'

  # Repository hooking
  get 'pipeline(/:pipeline_name)/repositories', :as => 'pipeline_repositories', :to => 'route_repositories#list'
  post 'pipeline/repositories/:repository_id', :as => 'pipeline_repository_enable', :to => 'route_repositories#enable'
  delete 'pipeline/repositories/:repository_id', :as => 'pipeline_repository_disable', :to => 'route_repositories#disable'
  get 'pipeline/repositories/validate/:repository_id', :as => 'pipeline_repository_validate', :to => 'route_repositories#validate'
  get 'pipeline/repositories/reload', :as => 'pipeline_repositories_reload', :to => 'route_repositories#reload'

  # Job display
  get 'pipeline(/:pipeline_name)/jobs(/:payload_filter/:payload_value)', :to => 'route_jobs#all', :as => 'pipeline_jobs'
  get 'pipeline/job/:job_id', :to => 'route_jobs#details', :as => 'pipeline_job'
  get 'pipeline/job/:job_id/status', :to => 'route_jobs#job_status', :as => 'pipeline_job_status'
end
