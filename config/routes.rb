Rails.application.routes.draw do

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
  resources :notices
  # NOTICES CONTROLLER END

  constraints subdomain: false do
    get ':any', to: redirect(subdomain: 'www', path: '/%{any}', status: 301), any: /.*/
  end

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    post "/complete_auth" => "omniauth_callbacks#complete_auth"
  end

  root   'home#index'
  resources :users, only: [:show], path: 'user'
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

  get 'pet/update_breeds' => 'mypets#update_breeds', path: 'pet/update_breeds', as: 'update_breeds'
  resources :mypets, path: 'pet' do
    get :do_main, path: 'attach/:id'
    delete :a_delete, path: 'attach/:id'
    member do
      get :vote
      end
  end





  get 'reviews/:breed_translate/:id' => 'reviews#show', as: :review
  resources :reviews, except: [:show] do
    resources :comments, defaults: { commentable: 'reviews' }
  end

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
      resources :blogs,    controller: 'admin/blogs',    as: 'admin_blogs' do
        get :approve
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
    end
  end
  # ADMIN CONTROLLER BEGIN



  resources :writer

  get  'dialogs'                => 'dialogs#index',        as: :dialogs
  get  'dialogs/:nickname'      => 'dialogs#show',         as: :dialogs_show
  post 'dialogs/:nickname/send' => 'dialogs#send_message', as: :dialogs_send
  get '*path' => redirect('/')
end
