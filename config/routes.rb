Feedback::Application.routes.draw do
  root :to => 'sessions#new'
  
  resources :sessions  
  match 'signin', to: 'sessions#new', :as=>:signin
  match 'signout', to: 'sessions#destroy', :as=>:signout
  
  resources :users  
  match '/cus_signup',  to: 'users#new', :as=>:signup
  match '/cus_create',  to: 'users#create', :as=>:cus_create
  
  match '/cus_home',  to: 'users#cus_home', :as=>:cus_home
  match '/cus_personal_information', to: 'users#cus_detail', :as=>:cus_detail
  match '/cus_edit_information', to: 'users#cus_edit', :as=>:cus_edit
  match '/cus_update_information', to: 'users#cus_update', :as=>:cus_update
  match '/reset_pwd', to: 'users#reset_pwd', :as=>:reset_pwd
  match '/update_pwd', to: 'users#update_pwd', :as=>:update_pwd
  match '/cus_get_agency', to: 'users#cus_get_agency', :as=>:cus_get_agency
  match 'get_related_staff', to: 'users#get_related_staff', :as=>:get_related_staff
#NATAS OPERATION
  match '/natas_home',  to: 'users#natas_home', :as=>:natas_home  
  match '/natas_add_new_user',  to: 'users#natas_add_new_user', :as=>:natas_add_new_user  
  match '/natas_create_new_user',  to: 'users#natas_create_new_user', :as=>:natas_create_new_user    
#MEMBER OPERATION
  match '/mbr_home',  to: 'users#mbr_home', :as=>:mbr_home  
  match '/mbr_add_new_user',  to: 'users#mbr_add_new_user', :as=>:mbr_add_new_user  
  match '/mbr_create_new_user',  to: 'users#mbr_create_new_user', :as=>:mbr_create_new_user
  
  
  resources :cases  
  #CUSTOMER
  match '/cus_new_case', to: 'cases#cus_new_case', :as=>:cus_new_case
  match '/cus_create_case', to: 'cases#cus_create_case', :as=>:cus_create_case
  match '/case_show', to: 'cases#case_show', :as=>:case_show
  match '/case_destroy', to: 'cases#case_destroy', :as=>:case_destroy
  match '/case_detail', to: 'cases#case_detail', :as=>:case_detail  
  match '/case_edit', to: 'cases#case_edit', :as=>:case_edit   
  match '/case_update', to: 'cases#case_update', :as=>:case_update  
  #NATAS
  match '/staff_view_case', to: 'cases#staff_view_case', :as=>:staff_view_case
  #MEMBER
  
    
  resource :processings
  #match '/response_new', to: 'processings#response_new', :as=>:response_new   
  #match '/response_forward', to: 'processings#forward_response', :as=>:forward_response   
  #match '/response_create_new', to: 'processings#response_create_new', :as=>:response_create_new  
  match '/natas_select_staff', to: 'processings#natas_select_staff', :as=>:natas_select_staff
  match '/natas_assign_case', to: 'processings#natas_assign_case', :as=>:natas_assign_case
  match '/case_processing', to: 'processings#case_processing', :as=>:case_processing
  match '/response_case', to: 'processings#response_case', :as=>:response_case
  match '/create_response', to: 'processings#create_response', :as=>:create_response
  match '/forward_contactlist', to: 'processings#forward_contactlist', :as=>:forward_contactlist
  match '/cus_evaluate_service', to: 'processings#cus_evaluate_service', :as=>:cus_evaluate_service

  resource :feedback
  match '/cus_new_feedback', to: 'feedbacks#cus_new_feedback', :as=>:cus_new_feedback
  match '/cus_create_feedback', to: 'feedbacks#cus_create_feedback', :as=>:cus_create_feedback
  
  match '/natas_view_feedback_detail', to: 'feedbacks#natas_view_feedback_detail', :as=>:natas_view_feedback_detail 
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
