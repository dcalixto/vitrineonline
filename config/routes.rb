Vitrineonline::Application.routes.draw do


  mount Logster::Web => "/logs" 


  get "/opensearch",  to: "application#opensearch"

  mount Soulmate::Server, :at => "/autocomplete"

  # ADMIN

  scope 'dcalixto84abcd152567' do
    #mount Resque::Server => "/resque"


    namespace :admin do


      root to: 'base#index'
      resources :users, :vitrines, :products, :feedbacks, :orders do
        delete 'destroy_all', on: :collection
      end
    end
  end

  # SESSION
  resources :sessions, only: [:create, :new, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  match '/logout', to: 'sessions#destroy', via: :get
  match 'auth/:provider/callback', to: 'sessions#omniauth_callback'

  # CONTATCT
  resources :contacts, only: [:new, :index, :create]

  # REPORTS
  resources :reports, only: [:new, :create]

  # REPORTS
  resources :notifications, only: [:index]


  # USER
  get 'welcome', to: 'users#welcome', as: 'welcome'

  resources :users, only: [:new, :create, :edit, :update, :show, :destroy] do
    resources :passwords,only: [:new, :create]

    member do
      #  get :products
      get :confirm_email
      get :report
      get :message
      get :message_user

      get :feedbacks


    end


    collection do
      get :feedbacks
      post '/:id/feedbacks', to: 'users#feedbacks', as: :search_feedbacks
      post '/:id', to: 'users#show', as: :feedbacks_search


    end
  end





  #BLOCKS
      resources :blocks, only: [:show]
      resources :eletronics, only: [:index, :show]
      resources :supplements, only: [:index, :show]
      resources :sports, only: [:index, :show]
      resources :autos, only: [:index, :show]
      resources :foods, only: [:index, :show]
      resources :books, only: [:index, :show]
      resources :houses, only: [:index, :show]
      resources :arts, only: [:index, :show]
      resources :tools, only: [:index, :show]
      resources :virtuals, only: [:index, :show]






  # FEEDBACKS
  resources :feedbacks, only: [:create] do
    collection do
      get :completed
      post :completed
      get :awaiting
    end
  end

  resources :password_resets, only: [:new, :create, :update, :edit]




  resources :conversations do
    resources :messages, only: [:create, :show]

    member do
      get :participants
      get :fail
    end

  end

  # VITRINE
  resources :vitrines, only: [:new, :create, :edit, :update, :show] do
    resources :policies, only: [:edit, :update, :new, :create]

    resources :announcements, only: [:new, :create]
    # resources :coupons, only: [:new, :create, :index]
    resources :marketings, only: [:edit, :update]

    resources :invoices, only: [:index, :show] do
      collection do
        match '/' => 'invoices#index', via: [:get, :post], as: :invoices
      end
    end

    resources :views, only: [:index] do
      collection do
        match '/' => 'views#index', via: [:get, :post], as: :views
      end
    end

    member do

      get :feedbacks

      get :policy
      get :message
      get :message_box
      put "like", to: "vitrines#upvote"
      put "dislike", to: "vitrines#downvote"
    end

    collection do
      #  match '/:id?view=feedbacks' => 'vitrines#feedbacks', via: [:get, :post], as: :vitrine_feedbacks

      post '/:id/feedbacks', to: 'vitrines#feedbacks', as: :search_feedbacks
      post '/:id/products', to: 'vitrines#products', as: :search_products





      get :feedbacks
      get :products
      get :user_votes
    end

    member do
      get :sales_report
      #  get :update_vitrine_select, as: :update_vitrine_select
      get :report
      get :tag
      get :branded
      # put :branded_true
      #  match :feedbacks
    end



  end


  resources :brands, only: [:new,:create] 



  #get '/vitrines/branded', to: 'vitrines#branded', as: :branded
  #put '/vitrines/branded_true', to: 'vitrines#branded_true', as: :branded_true





  #TODO CHANGE FEEDBACK VITRINE
  post '/vitrines/:id' => 'vitrines#show'









  # ORDER & CART & TRANSACTION
  post '/carts/add/:id', to: 'carts#add', as: :add_to_carts

  # put '/carts/user_address/', to: 'carts#user_address', as: :user_address

  post  '/orders/:id/checkout', to: 'orders#checkout', as: :calculate_ship

  #post "/orders/:id/checkout" , as: "calculate_ship"


  resources :transactions, only: [:show] 

  resources :odatas, only: [:index] do

    collection do
      match :sold
      match :purchased
    end
  end


  resources :carts, only: [:index] 
  resources :orders, only: [:index, :update, :destroy] do


    resource :dispute do

      resources :comments

      post 'upload'=>'dispute#upload'

      member do
        post :finish
        get :closed
      end




    end

    resources :stocks, only: [:index, :destroy] do
      collection do
        match '/' => 'stocks#index', via: [:get, :post], as: :products
      end
    end

    member do
      get :checkout
      post :buy
      post :ipn_notification
      get :fail
      get :sold
      get :purchased
      get :sent
      get :paid
      get :canceled


      get :track
      put :track_done
      put :track_sent

      #get :dispute
      #post :dispute_sent
      #put :dispute_done

    end

    collection do
      match :sold
      match :purchased
      match :sent

      match :paid
      match '/sold?status=sent ' => 'orders#sold', via: [:get,  :post], as: :vitrine_sent
      match '/sold?status=paid ' => 'orders#sold', via: [:get, :post], as: :vitrine_sold



      match '/purchased?status=paid' => 'orders#purchased', via: [:get, :post], as: :user_paid
      match '/purchased?status=sent' => 'orders#purchased', via: [:get, :post], as: :user_sent
    end
  end

  get '/orders/confirmation', to: 'orders#confirmation' #, as: :vitrine_sent

  get '/orders/:id/sent', to: 'orders#sent' #, as: :vitrine_sent



  # CATEGORIES
  resources :genders, only: [:show]
  resources :categories, only: [:show]
  namespace :categories, as: '' do
    resources :subcategories, only: [:show]
  end

  get 'tags/tag' => 'products#index', :as => :tag
  get 'products/tags' => 'products#tags', :as => :tags


  resources :pdatas, only: [:show]




  # PRODUCTS
  resources :products do
    member do
      get :sold_info
      get :buyer
      get :views

      get :seller
      get :tag
      get :probacks
      get :next_step
      get :report, to: 'products#report'
      get :message_product
      put 'like', to: 'products#pupvote'
      put 'dislike', to: 'products#pdownvote'
    end

    collection do
      get :created_at
      # post '/:id', to: 'products#show', as: :feedbacks_search
      #post '/:id/feedbacks', to: 'products#feedbacks', as: :search_feedbacks


      post '/:id', to: 'products#show', as: :probacks_search
      post '/:id/probacks', to: 'products#probacks', as: :search_probacks



      # get 'search'
      get :autocomplete
      get 'auth/:provider/callback', to: 'products#omniauth_callback'
      get :names
    end





    resources(:steps,
              controller: 'product/steps',
              only: [:show, :update]
             )
  end






  namespace :dynamic_selectable do
    get 'categories/:category_id/subcategories', to: 'category_subcategories#index', as: :category_subcategories
    get 'gender/:gender_id/categories', to: 'gender_categories#index', as: :gender_categories

    get 'state/:state_id/cities', to: 'state_cities#index', as: :state_cities

    get 'block/:block_id/genders', to: 'block_genders#index', as: :block_genders
    get 'block/:block_id/eletronics', to: 'block_eletronics#index', as: :block_eletronics
    get 'block/:block_id/supplements', to: 'block_supplements#index', as: :block_supplements
    get 'block/:block_id/houses', to: 'block_houses#index', as: :block_houses
    get 'block/:block_id/autos', to: 'block_autos#index', as: :block_autos
    get 'block/:block_id/sports', to: 'block_sports#index', as: :block_sports
    get 'block/:block_id/tools', to: 'block_tools#index', as: :block_tools
    get 'block/:block_id/arts', to: 'block_arts#index', as: :block_arts
    get 'block/:block_id/virtuals', to: 'block_virtuals#index', as: :block_virtuals

  end

  resources :departments, only: [:index]
  resources :rankings, only: [:index]

  resources :home, only: [:index]
  # FOOTERS & TOP NAV
  resources :contacts, only: [:index, :new, :create]

  resources :images, only: [:new, :create, :edit,:update]
  resources :logo, only: [:edit, :update]
  resources :avatar, only: [:edit, :update]


  # MISC
  root to: 'home#index'

  match '(errors)/:status', to: 'errors#show', constraints: { status: /\d{3}/ } # via: :all


end
