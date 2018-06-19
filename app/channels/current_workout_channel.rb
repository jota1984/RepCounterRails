class CurrentWorkoutChannel < ApplicationCable::Channel
  def subscribed
    stream_from "current_workout_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
