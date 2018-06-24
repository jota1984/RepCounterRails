json.workouts @workouts do |workout| 
  json.id workout.id
  json.start_time workout.start_time
  json.pushups workout.pushups 
  json.squats workout.squats 
end
