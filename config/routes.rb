Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'test' => 'api#test'
  namespace :api, defaults: {format: :json}, path: "/api" do
    namespace :v1, path: "/v1" do

    end
  end
end
