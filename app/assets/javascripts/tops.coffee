# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  dispatcher = new WebSocketRails(location.host + "/websocket")
  form = $("#form")
  text_input = $("#text_input")
  msg_box = $("#msg_box")

  form.submit((e) ->
    dispatcher.trigger("send_message", {msg: text_input.val()})
    text_input.val("")
    e.preventDefault()
  )

  dispatcher.bind("spread_message", (data) ->
    console.log(data)
    msg_box.append $("<li>").text(data.msg)
  )
