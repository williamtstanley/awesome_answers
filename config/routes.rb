Rails.application.routes.draw do
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]


    resources :sessions, only: [:new, :create] do
        delete :destroy, on: :collection
    end
    resources :users, only: [:new, :create]

    resources :questions do
        # this will define a route that will be '/questions/search' and it will point to the questions controller
        # 'search' action
        # on: :collection makes the route not have an 'id' or a 'question_id' on it.
        # get :search, on: :collection
        # this will generate a route 'question/:id/flag' and it will point to questions controller 'flag' action
        # on: :member makes the route include an ':id' in it similar to the 'edit'
        # post :flag, on: :member

        #this will make all the answers routes nested within 'questions' which means all the answers routes will be
        # prepended with '/questions/:question_id/'
        resources :answers, only: [:create, :destroy]
        resources :likes, only: [:create, :destroy]
        resources :votes, only: [:create, :update, :destroy]
    end
    resources :likes, only: [:index]

    #index page
    root "home#index"


    #about page
    # get "/about" => "home#about"
    #note that helpers are only for  URL portion of the route and has nothing to do with the HTTP verbs
    # Also note that the helper must be unique.
    # get "/greet/:name" => "home#greet", as: :greet


    # get "/cowsay" => "cowsay#index"
    # post "/cowsay" => "cowsay#create"

    # get "/temp" => "temp#temp"
    # post "/temp" => "temp#convert"

    # # QUESTIONS AND comments
    # delete "/questions/:id" => "questions#destroy"
    # get "/questions/:id/edit" => "questions#edit"
    # post "/questions/:id/comments" => "comments#create"
    # get "/faq" => "home#faq"


    # BILL SPLITTER
    # get "/bill_splitter" => "bill_splitter#index"
    # post "/bill_splitter" => "bill_splitter#split"

    # RANDOM name
    # get "/random_name" => "random_name#random"
    # post "/random_name" => "random_name#randomize"

    # get "/admin/questions" => "questions#index"

    # namespace :admin do
    #     resources :questions
    # end




end
