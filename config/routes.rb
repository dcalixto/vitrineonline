Vitrineonline::Application.routes.draw do
  # SESSION
  resources :sessions, only: [:create, :new, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  match '/logout', to: 'sessions#destroy', via: :get
  match 'auth/:provider/callback', to: 'sessions#omniauth_callback'

  # CONTATCT
  resources :contacts, only: [:new, :index, :create]

  # USER
  resources :users do
    resources :passwords

    member do
      get :feedbacks
      post :feedbacks
      get :update_city_select, as: :update_city_select
      get :products
    end

    collection do
      post '/:id', to: 'users#show', as: :feedbacks_search
    post '/:id/feedbacks', to: 'users#feedbacks', as: :search_feedbacks
    end
  end



  # FEEDBACK
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

    collection do
      get :chatbox, action: 'chatbox'
    end
  end

  # VITRINE
  resources :vitrines do

    collection do
      post '/:id', to: 'vitrines#show', as: :feedbacks_search
      post '/:id', to: 'vitrines#show', as: :products_search
      match '/:id/stocks', to: 'stocks#index', as: :search_stocks
      match '/:id/views', to: 'views#index', as: :views_search
    post '/:id/feedbacks', to: 'vitrines#feedbacks', as: :search_feedbacks
    end

    member do
      get :sales_report
      get :update_vitrine_select, as: :update_vitrine_select
      put 'like', to: 'vitrines#upvote'
      put 'dislike', to: 'vitrines#downvote'
        get :tag
    end

    resources :policies, only: [:edit, :update]
    resources :stocks, only: [:index, :destroy]
    resources :views, only: [:index]
    resources :announcements, only: [:new, :create]
    resources :marketings, only: [:edit, :update]

    resources :invoices, only: [:index, :show] do
      collection do
        post :search, to: 'invoices#index'
      end
    end

    member do
      get :products
      get :feedbacks
      post :feedbacks
      get :policy
      get :message
      post :products
    end
  end

  # ORDER & CART & TRANSACTION
  post '/carts/add/:id', to: 'carts#add', as: :add_to_carts
  post '/carts/buy_now/:id', to: 'carts#buy_now', as: :buy_now_to_carts
  put '/carts/user_address/', to: 'carts#user_address', as: :user_address

  resources :carts, only: [:index]
  resources :orders, only: [:index, :update, :destroy] do
    member do
      get :checkout
      get :buy
      post :ipn_notification
      get :fail
      get :fail2
      get :sent
    end

    collection do
      get :sold
      get :purchased
      get :sent
      post :purchased
      post :sent
      post :sold
      post '/:id', to: 'orders#purchased', as: :orders_search
    end
  end

  resources :transactions, only: [:index, :show]

  # CATEGORIES
  resources :genders, only: [:show]
  resources :categories, only: [:show]
  namespace :categories, as: '' do
    resources :subcategories, only: [:show]
  end

  # PRODUCT
  #  get 'products/update_category_select/:id', :controller=>'products', :action => 'update_category_select'
  #  get 'products/update_subcategory_select/:id', :controller=>'products', :action => 'update_subcategory_select'

  get 'products/tags' => 'products#tags', :as => :tags

  resources :products do

    member do
      get :sold_info
      get :buyer
      get :seller
      get :tag
      get :feedbacks
      get :next_step
      put 'like', to: 'products#upvote'
      put 'dislike', to: 'products#downvote'
    end

    collection do
      get :created_at
      post '/:id', to: 'products#show', as: :feedbacks_search
        post '/:id/feedbacks', to: 'products#feedbacks', as: :search_feedbacks
    end

    resources(:steps,
              controller: 'product/steps',
              only: [:show, :update]
             )



  end

  resources :home, only: [:index]

  # FOOTERS & TOP NAV
  resources :contacts, only: [:index, :new, :create]

  # MISC
  root to: 'home#index'

  match '(errors)/:status', to: 'errors#show', constraints: { status: /\d{3}/ } # via: :all
end
