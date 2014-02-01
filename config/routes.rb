ShoolooV2::Application.routes.draw do

resources :users do
  member do
    get :following, :followers,  
        :posts, :rated_posts, :commented_posts, :alarmed_posts,
        :comments, :alarmed_comments, 
        :liked_posts, :liked_comments, 
        :inviter, :invited,
        :show_activity, :my_abilities, :gift_receiving, :gift_giving, 
        :change_password, :common_core_I_can, 
        :student_common_core, :student_homework, :lessons, 
        :assignments, :responses, :teacher_dashboard, :past_due_assignments,
        :grading_results, :report_card, :keeps
    post :update_password
  end
  collection do 
    get :search, to: 'users#index'
    get :search_hidden, to: 'users#hidden' 
  end
end

resources :lessons, path: '/common-core-math-lesson-plans' do
  resources :likes, only: [:create, :destroy]
  get :comment
  post :comments
  collection { get :search, to: 'lessons#index' }
end

resources :posts, path: '/common-core-math-word-problems' do
  resources :keeps
  resources :gradings
  resources :likes, only: [:create, :destroy]
  resources :invites, only: :create
  resources :assignments
  resources :ratings 
  resources :comments do
    resources :alarms, only: [:create, :destroy]
  end
  resources :alarms, only: [:create, :destroy]
  member do
    get :raters
  end
  collection { get :search, to: 'posts#index' }
  get '/teacher_view', to: 'posts#teacher_view'
end

resources :ratings do
  member do
    get :operations, :improvements, :flags
  end
end

resources :comments do
  resources :gradings
  resources :alarms
  resources :likes, only: [:create, :destroy]
end

resources :authorizations do 
  member do
    put :decline, :reset_student_password
    delete :teacher_delete_auth
  end
  collection { post :search, to: 'authorizations#new' }
  collection { get :search_student, to: 'authorizations#index' }
end

resources :referrals do 
  collection { post :search, to: 'referrals#new' }
end

resources :videos do
  collection { get :search, to: 'videos#index' }
  get :premium, to: 'videos#premium'
end

resources :assignments do 
  resources :responses
end

resources :responses do
  resources :posts
  resources :comments
end

resources :user_imports
resources :sessions, only: [:new, :create, :destroy]
resources :relationships, only: [:create, :destroy]
resources :nudges, only: [:create, :destroy]
resources :standards, path: '/common-core-math-I-can' 
resources :alarms
resources :likes, only: [:create, :destroy]
resources :invites, only: :create
resources :activities 
resources :password_resets
resources :ref_checks
resources :user_steps
resources :gifts
resources :choices
resources :messages
resources :twilios
resources :gradings
resources :reminders
resources :keeps

  root to: "static_pages#home"
 
  get '/about', to: 'static_pages#about'
  get '/team', to: 'static_pages#team'
  get '/advisors', to: 'static_pages#advisors'
  get '/help', to: 'static_pages#help'
  get '/rules', to: 'static_pages#rules'
  get '/terms', to: 'static_pages#terms'
  get '/privacy', to: 'static_pages#privacy'
  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  get '/signout', to: 'sessions#destroy'
  get '/alarmed-posts', to: "alarms#alarmed_posts", as: :alarmed_posts
  get '/my-alerts', to: "users#show_activity", as: :my_alerts
  get '/my-powers', to: "users#my_abilities", as: :my_abilities
  get '/hidden', to: "users#hidden"
  get '/my-gifts', to: "events#gift_receiving", as: :gift_receiving
  get '/my-fans', to: "events#gift_giving", as: :gift_giving
  get '/contact', to: "messages#new" 
  get '/pd', to: "videos#pd" 
  get '/standards/common-core-math-I-can-grade-k', to: "standards#grade_k", as: :grade_k
  get '/standards/common-core-math-I-can-grade-1', to: "standards#grade_1", as: :grade_1
  get '/standards/common-core-math-I-can-grade-2', to: "standards#grade_2", as: :grade_2
  get '/standards/common-core-math-I-can-grade-3', to: "standards#grade_3", as: :grade_3
  get '/standards/common-core-math-I-can-grade-4', to: "standards#grade_4", as: :grade_4
  get '/standards/common-core-math-I-can-grade-5', to: "standards#grade_5", as: :grade_5
  get '/standards/common-core-math-I-can-grade-6', to: "standards#grade_6", as: :grade_6
  get '/standards/common-core-math-I-can-grade-7', to: "standards#grade_7", as: :grade_7
  get '/standards/common-core-math-I-can-grade-8', to: "standards#grade_8", as: :grade_8
  get '/standards/common-core-math-practices', to: "standards#practice", as: :practice
  get '/teacher/common-core-math-dashboard', to: "static_pages#sample_dashboard", as: :sample_dashboard
  get '/teacher/common-core-math-assignment', to: "static_pages#sample_assignment", as: :sample_assignment


  get '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/} 
end
