App.current_workout = App.cable.subscriptions.create "CurrentWorkoutChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.workout_id?
      id = parseInt($('meta[name=workout_id]').attr("content"))
      if id != data.workout_id
        return 
    if data.finished 
      location.reload() 
      return 
    if data.squats?
      $('#squat_count').text(data.squats) 
    if data.pushups?
      $('#pushup_count').text(data.pushups) 
    if data.temperature?
      $('#temperature_realtime').text(data.temperature) 
    if data.heart_rate?
      $('#heartrate_realtime').text(data.heart_rate) 
    if data.current_set?
      htmlCurrentSet = parseInt($('#sets tr:last-child td:first-child').text())
      if data.current_set != htmlCurrentSet 
        location.reload()
      else 
        $('#sets tr:last-child td:nth-child(3)').text(data.set_count)
        $('#sets tr:last-child td:nth-child(4)').text(data.set_duration)
        
    # Called when there's incoming data on the websocket for this channel
