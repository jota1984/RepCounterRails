Rails.application.routes.draw do
  get 'rep_sets' => 'rep_sets#index' 

  get 'rep_sets/:id' => 'rep_sets#show' 

  post 'pushup' => 'workouts#add_pushup' 
  post 'squat' => 'workouts#add_squat'  
  post 'bio' => 'workouts#add_bio' 

  resources :workouts, only: [:index, :show, :create, :update ] do
    resources :rep_sets, only: [:index,:show]
    resources :bio_entries, only: [:index] 
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
