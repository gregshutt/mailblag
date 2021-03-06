Rails.application.routes.draw do
  root 'posts#index'

  get '/login', to: "user_sessions#new"
  post '/login', to: "user_sessions#create"
  get '/logout', to: "user_sessions#destroy"

  get '/site-login', to: "site_logins#new"
  post '/site-login', to: "site_logins#create"

  resources :posts do
    get 'calendar', on: :collection
    get 'search', on: :collection
  end
end

# == Route Map
#
#         Prefix Verb   URI Pattern               Controller#Action
#           root GET    /                         posts#index
#          login GET    /login(.:format)          user_sessions#new
#                POST   /login(.:format)          user_sessions#create
#         logout GET    /logout(.:format)         user_sessions#destroy
#     site_login GET    /site-login(.:format)     site_logins#new
#                POST   /site-login(.:format)     site_logins#create
# calendar_posts GET    /posts/calendar(.:format) posts#calendar
#   search_posts GET    /posts/search(.:format)   posts#search
#          posts GET    /posts(.:format)          posts#index
#                POST   /posts(.:format)          posts#create
#       new_post GET    /posts/new(.:format)      posts#new
#      edit_post GET    /posts/:id/edit(.:format) posts#edit
#           post GET    /posts/:id(.:format)      posts#show
#                PATCH  /posts/:id(.:format)      posts#update
#                PUT    /posts/:id(.:format)      posts#update
#                DELETE /posts/:id(.:format)      posts#destroy
#
