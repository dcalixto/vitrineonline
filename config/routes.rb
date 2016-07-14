
Vitrineonline::Application.routes.draw do


mount ResqueWeb::Engine => "/dcalixto86"
mount MemcachedManager::Routes, :at => '/dcalixto85'

  scope 'dcalixto84' do
    namespace :admin do
      root to: 'base#index'
      resources :users, :vitrines, :feedbacks, :orders do
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

  # USER

  resources :users, only: [:new, :create, :edit, :update, :show] do
    resources :passwords
       member do
      #  get :products
      get :confirm_email
      get :report
      get :message
      get :message_user



    end

 
 







    collection do
      get :feedbacks

      match '/:id?simpletabs_selected_tab=feedbacks' => 'users#feedbacks', via: [:get, :post], as: :user_feedbacks
    end
  end

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
    resources :policies, only: [:edit, :update]

    resources :announcements, only: [:new, :create]
    resources :coupons, only: [:new, :create, :index]
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
      #  match :feedbacks
    end
  end

#TODO CHANGE FEEDBACK VITRINE
  post '/vitrines/:id' => 'vitrines#show'


  # ORDER & CART & TRANSACTION
  post '/carts/add/:id', to: 'carts#add', as: :add_to_carts
  post '/carts/buy_now/:id', to: 'carts#buy_now', as: :buy_now_to_carts
  put '/carts/user_address/', to: 'carts#user_address', as: :user_address

  resources :carts, only: [:index]
  resources :orders, only: [:index, :update, :destroy] do
    resources :stocks, only: [:index, :destroy] do
      collection do
        match '/' => 'stocks#index', via: [:get, :post], as: :products
      end
    end

    member do
      get :checkout
      get :buy
      post :ipn_notification
      get :fail
      get :fail2
      get :sold
      get :purchased
      get :sent
      get :paid
    end

    collection do
      match :sold
      match :purchased
      match :sent
      match :paid

      match '/sold?status=sent ' => 'orders#sold', via: [:get, :post], as: :vitrine_sent
      match '/sold?status=paid ' => 'orders#sold', via: [:get, :post], as: :vitrine_sold
      match '/purchased?status=paid' => 'orders#purchased', via: [:get, :post], as: :user_paid
      match '/purchased?status=sent' => 'orders#purchased', via: [:get, :post], as: :user_sent
    end
  end

  resources :transactions, only: [:index, :show]

  # CATEGORIES
  resources :genders, only: [:show]
  resources :categories, only: [:show]
  namespace :categories, as: '' do
    resources :subcategories, only: [:show]
  end

  get 'tags/tag' => 'products#index', :as => :tag
  get 'products/tags' => 'products#tags', :as => :tags

  resources :products do
    member do
      get :sold_info
      get :buyer
      get :seller
      get :tag
      get :feedbacks
      get :next_step
      get :report, to: 'products#report'
      get :message_product
      put 'like', to: 'products#upvote'
      put 'dislike', to: 'products#downvote'
    end

    collection do
      get :created_at
      post '/:id', to: 'products#show', as: :feedbacks_search
      post '/:id/feedbacks', to: 'products#feedbacks', as: :search_feedbacks
      # get 'search'
      get :autocomplete
      get 'auth/:provider/callback', to: 'products#omniauth_callback'
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
  end

  resources :departments, only: [:index]
  resources :rankings, only: [:index]

  resources :home, only: [:index]
  # FOOTERS & TOP NAV
  resources :contacts, only: [:index, :new, :create]

  resources :images, only: [:new, :create]
  resources :logo, only: [:edit, :update]
  resources :avatar, only: [:edit, :update]
  
 
  # MISC
  root to: 'home#index'

  match '(errors)/:status', to: 'errors#show', constraints: { status: /\d{3}/ } # via: :all
end
