Rails.application.routes.draw do

  #NEW#
  get 'new' => 'new/home#index'

  #NEW#


  post '/tinymce_assets' => 'tinymce_assets#create'

  # ARTICLES CONTROLLER BEGIN
  resources :articles do
    resources :comments, defaults: { commentable: 'articles' }
    member do
      get :vote
    end
  end
  # ARTICLES CONTROLLER END

  # BLOGS CONTOLLER BEGIN
  get 'feed' => 'blogs#index'
  get 'feed/my' => 'blogs#my'
  resources :blogs, except: [:index, :my] do
    post :image_create, on: :collection
    put :image_create, on: :collection
    delete :a_delete, path: '/attach/:id', on: :collection
    get :my, on: :collection, path: '/feed/my'
    resources :comments, defaults: { commentable: 'blogs' }
    member do
      get :vote
    end
  end
  # BLOGS CONTOLLER END


  # COMMENTS CONTOLLER BEGIN

  # COMMENTS CONTOLLER BEGIN


  # NOTICES CONTROLLER BEGIN
  resources :notices, only: [:index, :create, :destroy] do
    get :followers, on: :collection
    get :following, on: :collection
    get :newpets,   on: :collection
    post :breed_subscribers_create, on: :collection, as: :breed_s, path: 'newpets-add'
    post :breed_subscribers_delete, on: :collection, as: :breed_d, path: 'newpets-del'
  end
  # NOTICES CONTROLLER END


  # PETS CONTROLLER BEGIN #
  resources :pets
  post 'pets/filter' => 'pets#index'
  # PETS CONTROLLER END #


  # REVIEWS CONTROLLER BEGIN #
  resources :reviews, except: [:show] do
    post :image_create, on: :collection
    put :image_create, on: :collection
    delete :a_delete, path: '/attach/:id', on: :collection
    resources :comments, defaults: { commentable: 'reviews' }, only: [:create, :destroy]
    member do
      get :vote
    end
  end
  get '/reviews/:breed_type' => 'reviews#breed_type', as: :reviews_type
  get '/reviews/:breed_type/:breed_translate' => 'reviews#breed_translate', as: :reviews_translate
  get 'reviews/:breed_type/:breed_translate/:id' => 'reviews#show', as: :review_show
  # REVIEWS CONTROLLER END #


  # MYPETS CONTROLLER BEGIN #
  get 'pet/update_breeds' => 'mypets#update_breeds', path: 'pet/update_breeds', as: 'update_breeds'
  resources :pets, path: 'pet' do
    post :image_create, on: :collection
    put :image_create, on: :collection
    get :do_main, path: 'attach/:id'
    delete :a_delete, path: '/pet_attach/:id', on: :collection
    member do
      get :vote
    end
  end
  # MYPETS CONTROLLER END #


  # SEARCH CONTROLLER BEGIN #
  resources :search, only: [:index]
  # SEARCH CONTROLLER END #

  constraints subdomain: false do
    get ':any', to: redirect(subdomain: 'www', path: '/%{any}', status: 301), any: /.*/
  end

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  devise_scope :user do
    post "/complete_auth" => "omniauth_callbacks#complete_auth"
  end

  root   'home#index'
  get 'index2' => 'home#index2'
  resources :users, only: [:show], path: 'user' do
    delete 'subscribers' => 'subscribers#destroy'
    resources :subscribers, only: [:create]
  end
  put 'users/update_avatar' => 'users#update_avatar'
  get 'users/update_cities', as: 'update_cities'
  get 'profile/edit' => 'users#edit', as: :edit_user
  put 'profile/edit' => 'users#update'
  resources :topics, path:'forum' do
    resources :posts
  end


  get    'user/:id/subscribe' => 'subscribes#subscribe', as: :subscribe
  get    'im/edit'           => 'home#edit'
  put    'im/edit'           => 'home#update'
  get    'refresh'           => 'home#refresh', as: :refresh
  get    'weekly'            => 'home#weekly',  as: :weekly









  resources :mini_reviews, path: '5kopeek', only: [:index, :new, :create]
  get '5kopeek/:breed_translate' => 'mini_reviews#breed', as: :breed_5kopeek


  get    'dogs/:translate'   => 'breeds#show',          as: :show_dogs_breed
  get    'cats/:translate'   => 'breeds#show',          as: :show_cats_breed
  get    'dogs'              => 'breeds#index_dogs',    as: :dogs_breed
  get    'cats'              => 'breeds#index_cats',    as: :cats_breed

  # ADMIN CONTROLLER BEGIN
  resources :admin do
    get 'log' => 'admin/logs#show', as: 'log', on: :collection
    get 'log/clear' => 'admin/logs#clear', as: 'log_clear', on: :collection
    collection do
      resources :articles, controller: 'admin/articles', as: 'admin_articles'
      resources :tags,     controller: 'admin/tags',     as: 'admin_tags'
      resources :blogs,    controller: 'admin/blogs',    as: 'admin_blogs' do
        get :approve
        get :notapprove
        get :pay_blog
      end
      resources :breeds,   controller: 'admin/breeds',   as: 'admin_breeds'
      resources :cities,   controller: 'admin/cities',   as: 'admin_cities'
      resources :comments, controller: 'admin/comments', as: 'admin_comments', except: [:new, :show] do
        get :approve
      end
      resources :forums,   controller: 'admin/forums',   as: 'admin_forums', only: [:index] do
        get :topic_approve
        get :topic_delete
        get :post_approve
        get :post_delete
      end
      resources :pets,     controller: 'admin/pets',     as: 'admin_pets' do
        get :approve
      end
      resources :users,    controller: 'admin/users',    as: 'admin_users' do
        get :block
        get :unblock
        get :approve
      end
      resources :mass_spam, controller: 'admin/mass_spam', as: 'admin_mass_spam'
      resources :badges,    controller: 'admin/badges',    as: 'admin_badges'
    end
  end
  # ADMIN CONTROLLER BEGIN

  get  'dialogs'                => 'dialogs#index',        as: :dialogs
  get  'dialogs/:nickname'      => 'dialogs#show',         as: :dialogs_show
  post 'dialogs/:nickname/send' => 'dialogs#send_message', as: :dialogs_send
  get '*path' => redirect('/')
end
