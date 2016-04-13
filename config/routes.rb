Vitrineonline::Application.routes.draw do



 scope 'dcalixto84' do
  namespace :admin do
      root :to => 'base#index'
      resources :users, :vitrines, :feedbacks,:orders, :votes do
        delete 'destroy_all', :on => :collection
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

  #REPORTS


  resources :reports, only: [:new, :create]

  # USER
  resources :users, only:[:new,:create,:edit,:update, :show ] do
    resources :passwords

    member do
      match :feedbacks
         get :update_city_select, as: :update_city_select
      get :products
       get :confirm_email
       match :report
    end


    collection do
       match '/:id' => 'users#show', via: [:get, :post], as: :feedbacks
       match '/:id/feedbacks' => 'users#feedbacks', via: [:get, :post], as: :search_feedbacks
    end


  end

# VOTES
resources :votes, only:[:index ] do
  collection do
get :products
get :vitrines
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
 collection do
     match '/' => 'conversations#index', via: [:get, :post], as: :search

 end
  end
   match '/offers/' => 'offers#index', via: [:get], as: :offers
  # VITRINE
  resources :vitrines,  only: [:new, :create,:edit,:update,:show] do
    resources :policies, only: [:edit, :update]
    resources :banners, only: [:new, :create]

    resources :announcements, only: [:new, :create]
    resources :offers, only: [:new, :create, :index]
    resources :marketings, only: [:edit, :update]


     resources :stocks, only: [:index, :destroy] do
      collection do
         match '/' => 'stocks#index', via: [:get, :post], as: :products

      end
    end

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

      match :feedbacks
        get :policy
      get :message
      match :products
    end



    collection do
      match '/vitrine_feedbacks' => 'vitrines#show', via: [:get, :post], as: :vitrine_feedbacks
     match '/vitrine_product' => 'vitrines#show', via: [:get, :post], as: :vitrine_products

 match '/:id/feedbacks' => 'vitrines#feedbacks', via: [:get, :post], as: :search_feedbacks
    end

    member do
      get :sales_report
      get :update_vitrine_select, as: :update_vitrine_select
      put 'like', to: 'vitrines#upvote'
      put 'dislike', to: 'vitrines#downvote'
      post :vote

   match :report
      get :tag
      match :feedbacks
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
      match :sold
       match :purchased
       match :sent
       match :paid

    end

    collection do
       match :sold
       match :purchased
       match :sent
       match :paid

match '/sold?status=sent ' => 'orders#sold', via: [:get, :post], as: :sent


match '/sold?status=paid ' => 'orders#sold', via: [:get, :post], as: :paid


match '/purchased?status=paid' => 'orders#purchased', via: [:get, :post], as: :paid

match '/purchased?status=sent' => 'orders#purchased', via: [:get, :post], as: :sent




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
      put 'like', to: 'products#upvote'
      put 'dislike', to: 'products#downvote'
   match :report, to: 'products#report'
    end

    collection do
      get :created_at
      post '/:id', to: 'products#show', as: :feedbacks_search
     post '/:id/feedbacks', to: 'products#feedbacks', as: :search_feedbacks
      #get 'search'
     get :autocomplete
    end


    resources(:steps,
              controller: 'product/steps',
              only: [:show, :update]
             )



  end


  namespace :dynamic_selectable do
    get 'categories/:category_id/subcategories', to: 'category_subcategories#index', as: :category_subcategories
    get 'gender/:gender_id/categories', to: 'gender_categories#index', as: :gender_categories
  end


resources :departments, only: [:index]
resources :rankings, only: [:index]



  resources :home, only: [:index]

  # FOOTERS & TOP NAV
  resources :contacts, only: [:index, :new, :create]

  # MISC
  root to: 'home#index'





  match '(errors)/:status', to: 'errors#show', constraints: { status: /\d{3}/ } # via: :all
end
