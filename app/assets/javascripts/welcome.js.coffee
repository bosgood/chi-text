# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#welcome_form').submit (event) ->
    event.preventDefault()
    $.post('/api/v1/messages/receive', {"From": $('#phone_num').val(), "Body": "welcome"} )
    return false
