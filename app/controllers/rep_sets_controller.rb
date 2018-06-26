class RepSetsController < ApplicationController
  def index
    if (params[:workout_id].nil?) 
      @rep_sets = RepSet.all 
    else
      workout = Workout.find(params[:workout_id]) 
      @rep_sets = workout.rep_sets
    end
  end

  def show
    @rep_set = RepSet.find(params[:id]) 
    @reps = @rep_set.reps
  end
end
