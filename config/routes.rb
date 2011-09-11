Bleeoo::Application.routes.draw do
  
  resources :blacklists
  match "/lookup" => "blacklists#lookup"

  # resources :videos, :only => [:index,:create,:show] do
  #   member do
  #     match "callback"
  #   end
  # end

  resource :user_session do
    member { get :auth_and_return_to }
  end
  
  match "/videos/callback" => "videos#callback"
  post "/videos" => "videos#create"
  get "/videos" => "videos#index"
  delete "/videos/:uid" => "videos#delete"
  get "/videos/:uid" => "videos#show", :as => "video"
  match "/videos/:uid/source.flv" => "videos#source", :as => "video_source"
  match "/videos/:uid/thumbnail.jpg" => "videos#thumbnail", :as => "video_thumbnail"
  match "/" => "welcome#index", :as => "home"
end
