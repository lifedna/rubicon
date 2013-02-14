Rubicon::Application.routes.draw do
  resources :web_apps, :web_app_instances, :log_jams, :web_servers,
            :machines, :nginx_vhosts

  match 'port-tracker' => 'port_tracker#index'
  match 'rails-dash'   => 'rails_dash#index'
  match 'status'       => 'status#index'
  root  :to            => 'rails_dash#index'
end
