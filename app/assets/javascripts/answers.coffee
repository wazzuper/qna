# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready_answer = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#edit-answer-' + answer_id).show();

$(document).on("turbolinks:load", ready_answer);
$(document).ready(ready_answer);
$(document).on('page:load', ready_answer);
$(document).on('page:update', ready_answer);
$(document).on('page:change', ready_answer);