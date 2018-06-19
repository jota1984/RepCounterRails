App.current_workout = App.cable.subscriptions.create "CurrentWorkoutChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.squats?
      $('#squat_count').text(data.squats) 
    if data.pushups?
      $('#pushup_count').text(data.pushups) 
    # Called when there's incoming data on the websocket for this channel
