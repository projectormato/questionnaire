# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  dispatcher = new WebSocketRails(location.host + "/websocket")

  ankes = ["good", "bad"]
  $("#anke").submit((e) ->
    result = {}
    for a in ankes
      $elem = $("#" + a)
      result[a] = $elem.val()
#      $elem.val("")
    dispatcher.trigger("result_update", {msg: result})
    e.preventDefault()
  )

  $.each(ankes, (a) ->
    dispatcher.bind(ankes[a] + "_update", (data) ->
      li = $("<li>").css(opacity: 0)
      $(".result_" + ankes[a]).append(li.html(data).addClass("list-group-item"))
      li.animate({opacity: 100}, 8000)
    )
  )

  dispatcher.bind("notice", (data) ->
    div = $("<div>").css({
      background: "white",
      position: "fixed",
      left: "100%",
      top: "0%",
      width: "10%",
      height: "10%",
    }).html("<h3>#{data}</h3>").addClass("text-center", "h3")
    $("body").append(div)
    div.animate({
      left: "-=" +div.width()+ "px",
    }, 300, () ->
      setTimeout(() ->
        div.remove()
      , 3000))
    for a in ankes
      $("#" + a).val("")
  )
