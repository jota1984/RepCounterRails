class BioEntriesController < ApplicationController
  def index
    workout = Workout.find(params[:workout_id]) 
    @bio_entries = workout.bio_entries 
  end
end
