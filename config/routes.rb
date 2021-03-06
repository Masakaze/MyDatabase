Rails.application.routes.draw do
  # TaskInfos
  resources :task_infos do
    collection do
      get 'task_status_change'
    end
  end
  # TaskInfoLogs
#  post 'task_info_logs', to: 'task_info_logs#create'
#  put 'task_info_logs/(.:format)', to: 'task_info_logs#update'
  resources :task_info_logs, :only => [:create, :update]
  # TaskCategory
  resources :task_categories, :only => [:new, :create]

  # TaskDB 外部登録周り
  namespace :task_db_http_request do
    resources :task_infos do
      collection do
        get 'read_reminder'
        post 'upload_comment'
      end
    end
  end

  #
  resources :game_genres
  resources :game_infos do
    collection do
      get 'switch_by_platform'
      get 'register_new_controller_manual'
      get 'register_new_game_action_form'
      get 'register_new_game_action'
    end
  end

  # 管理者ページ
  namespace :admin do
    get 'task_db', to: 'task_dbs#index'
    get 'task_db/resave_task_infos', to: 'task_dbs#resave_task_infos'
  end

  get 'twitters', to: 'twitters#index'
  get 'twitters/get_home_timeline', to: 'twitters#get_home_timeline'
  get 'twitters/post_tweet_by_get', to: 'twitters#post_tweet_by_get'
  post 'twitters/post_tweet', to: 'twitters#post_tweet'
  get 'twitters/python', to: 'twitters#python'
  get 'twitters/parse_sentence', to: 'twitters#parse_sentence'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
