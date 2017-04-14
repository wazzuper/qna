vote = ->

  $('.vote').bind 'ajax:success', (e, data, status, xhr) ->
    vote = $.parseJSON(xhr.responseText);
    type = vote.type;
    id =  vote.id;
    container = '.vote-' + type + '-' + id
    $(container + ' .rating-' + type + '-' + id).html('Rating: ' + vote.votes_count);
    $(container + ' .vote-cancel-' + type + '-' + id).removeClass(' hidden')
    $(container + ' .vote-up-' + type + '-' + id).addClass(' hidden')
    $(container + ' .vote-down-' + type + '-' + id).addClass(' hidden')

$(document).on('turbolinks:load', vote);
$(document).ready(vote);
$(document).on('page:load', vote);
$(document).on('page:update', vote);
$(document).on('page:change', vote);