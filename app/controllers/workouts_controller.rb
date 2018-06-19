class WorkoutsController < ApplicationController

	skip_before_action :verify_authenticity_token

  def show
    @workout = Workout.find(params[:id])
  end

  def index
    @workouts = Workout.all 
  end

  def create
    @workout = Workout.new(start_time: DateTime.now, pushups: 0, squats: 0)     
    @workout.save                                                               
    redirect_to @workout 
  end

  def add_squat                                                                 
    @workout = Workout.last                                                     
    count = @workout.squats                                                     
    count += 1                                                                  
    @workout.update(squats: count)                                              
    render :nothing => true, :status => 200, :content_type => 'text/html'       
    ActionCable.server.broadcast 'current_workout_channel', squats: count
  end                                                                           
                                                                                
  def add_pushup                                                                
    @workout = Workout.last                                                     
    count = @workout.pushups                                                    
    count += 1                                                                  
    @workout.update(pushups: count)                                             
    render :nothing => true, :status => 200, :content_type => 'text/html'       
    ActionCable.server.broadcast 'current_workout_channel', pushups: count
  end           
end
