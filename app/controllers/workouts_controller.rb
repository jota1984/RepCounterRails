class WorkoutsController < ApplicationController

	skip_before_action :verify_authenticity_token

  def show
    @workout = Workout.find(params[:id])
    @rep_sets = @workout.rep_sets

    respond_to do |format| 
      format.json 
      format.html 
    end
  end

  def index
    @workouts = Workout.all   

    respond_to do |format| 
      format.json 
      format.html 
    end
  end

  def create
    @workout = Workout.new(start_time: DateTime.now, pushups: 0, squats: 0)     
    @workout.save                                                               
    redirect_to @workout 
  end

  def add_squat                                                                 
    #get current workout 
    @workout = Workout.last                                                     
    #increase counter
    count = @workout.squats                                                     
    count += 1                                                                  
    @workout.update(squats: count)                                              

    #response
    render :nothing => true, :status => 200, :content_type => 'text/html'       
    
    #get current set 
    @rep_set = RepSet.last 
    #if no set or current set belonged to previous workout
    if (@rep_set.nil? or @rep_set.workout != @workout ) 
      #create new set for current workout 
      @rep_set = @workout.rep_sets.create(number: 1, rep_type: "squat") 
    #if set is not the right type
    elsif (@rep_set.rep_type != "squat") 
      #create next set for current workout
      current_set = @rep_set.number
      @rep_set = @workout.rep_sets.create(number: current_set + 1, rep_type: "squat") 
    end
    #create rep on set
    @rep_set.reps.create(date: DateTime.now, rep_type: "squat") 
    ActionCable.server.broadcast 'current_workout_channel', 
      { squats: count, 
        current_set: @rep_set.number, 
        set_count: @rep_set.count, 
        set_duration: @rep_set.duration.round,
        workout_id: @workout.id } 
    
  end                                                                           
                                                                                
  def add_pushup                                                                
    #get current workout
    @workout = Workout.last                                                     
    #increment count
    count = @workout.pushups                                                    
    count += 1                                                                  
    @workout.update(pushups: count)                                             
    #empty response
    render :nothing => true, :status => 200, :content_type => 'text/html'       
    
    #get current set 
    @rep_set = RepSet.last 
    #if no set or current set belonged to previous workout
    if (@rep_set.nil? or @rep_set.workout != @workout ) 
      #create new set for current workout 
      @rep_set = @workout.rep_sets.create(number: 1, rep_type: "pushup") 
    #if set is not the right type
    elsif (@rep_set.rep_type != "pushup") 
      #create next set for current workout
      current_set = @rep_set.number
      @rep_set = @workout.rep_sets.create(number: current_set + 1, rep_type: "pushup") 
    end
    #create rep on set
    @rep_set.reps.create(date: DateTime.now, rep_type: "pushup") 
    ActionCable.server.broadcast 'current_workout_channel', 
      { pushups: count, 
        current_set: @rep_set.number, 
        set_count: @rep_set.count, 
        set_duration: @rep_set.duration.round,
        workout_id: @workout.id } 
  end           
end
