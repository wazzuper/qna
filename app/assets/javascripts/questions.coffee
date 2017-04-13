# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready_question = ->
  $('.edit-question-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId');
    $('form#edit-question-' + question_id).show();

$(document).on("turbolinks:load", ready_question);
$(document).ready(ready_question);
$(document).on('page:load', ready_question);
$(document).on('page:update', ready_question);
$(document).on('page:change', ready_question);