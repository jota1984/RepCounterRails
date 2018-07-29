class WorkoutsController < ApplicationController

	skip_before_action :verify_authenticity_token

  def show
    @workout = Workout.find(params[:id])
    @rep_sets = @workout.rep_sets

    if @workout.finished? and @workout.reps.count > 0
      first_rep_time = @workout.reps.first.date
      @timeline_data = @rep_sets.map do |r| 
        [r.rep_type, r.start_time - first_rep_time, r.end_time - first_rep_time] 
      end
      @pie_data = ["pushup", "squat"].map do |t|
        [t+"s", @rep_sets.where(rep_type: t).to_a.map { |r| r.duration}.inject(0,:+)]
      end.to_h  
      @pie_data["rest"] = @workout.duration - @pie_data.values.inject(0,:+) 
    end

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
    @workout = Workout.new(start_time: DateTime.now, pushups: 0, squats: 0, finished: false)     
    @workout.save                                                               
    redirect_to @workout 
  end

  def update 
    @workout = Workout.find(params[:id])
    @workout.update(finished: true ); 
    redirect_to @workout
    ActionCable.server.broadcast 'current_workout_channel', 
      { finished: true, 
        workout_id: @workout.id } 
  end

  def add_squat                                                                 
    #get current workout 
    @workout = Workout.last                                                     
    if @workout.finished? 
      return
    end
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
    if @workout.finished?
      return
    end
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

  def add_bio
    @workout = Workout.last 
    if @workout.finished?
      return
    end
    if (params[:temp].nil? or params[:hr].nil?) 
      return 
    end
    @workout.bio_entries.create(date: DateTime.now, 
                                temperature: params[:temp],
                                heart_rate: params[:hr]) 
    render :nothing => true, :status => 200, :content_type => 'text/html'       
    ActionCable.server.broadcast 'current_workout_channel', 
      { temperature: params[:temp], 
        heart_rate: params[:hr], 
        workout_id: @workout.id } 

  end
end
