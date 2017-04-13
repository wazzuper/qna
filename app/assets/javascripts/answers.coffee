# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#edit-answer-' + answer_id).show();

  $('.answer-up-link').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    $('.rating-answer-' + vote.id).html('Rating: ' + vote.votes_count);

  $('.answer-down-link').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    $('.rating-answer-' + vote.id).html('Rating: ' + vote.votes_count);

$(document).on("turbolinks:load", ready);
$(document).ready(ready);
$(document).on('page:load', ready);
$(document).on('page:update', ready);
$(document).on('page:change', ready);