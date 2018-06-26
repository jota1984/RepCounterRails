Rails.application.routes.draw do
  get 'rep_sets' => 'rep_sets#index' 

  get 'rep_sets/:id' => 'rep_sets#show' 

  post 'pushup' => 'workouts#add_pushup' 
  post 'squat' => 'workouts#add_squat'  

  resources :workouts, only: [:index, :show, :create, :update ] do
    resources :rep_sets, only: [:index,:show]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
