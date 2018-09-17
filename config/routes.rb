Rails.application.routes.draw do
  get 'skus/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	get "/auth/:provider/callback" => "sessions#create"
  	# get "/auth/twitter" => "sessions#create"
	get "/signout" => "sessions#destroy"
	post "/sessions/create" => "sessions#create"
	get "/sessions/create" => "sessions#create"
	get "/sessions/log_in" => "sessions#log_in"
	root 'sessions#show'
	post "/skus/create" => "skus#create"
end
