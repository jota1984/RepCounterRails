Rails.application.routes.draw do
  get 'workouts/show'

  get 'workouts/index'

  get 'workouts/create'

  post 'pushup' => 'workouts#add_pushup' 
  post 'squat' => 'workouts#add_squat'  

  resources :workouts 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
