# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
  $('#extra-info').hide()
  $('#office_listed_0').click ->  $('#extra-info').hide( "fade" )
  $('#office_listed_1').click -> $('#extra-info').show( "fade" )

