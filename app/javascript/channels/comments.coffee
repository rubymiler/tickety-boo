jQuery(document).on 'turbolink:load', -> 
  comments = $('#comments')
  if comments.length > 0
    App.global_chat = App.cable.subscriptions.create {
      channel: 'TicketsChannel'
      ticket_id: comments.data('ticket-id')
    },
    connected: ->
    disconnected: ->
    received: (data) ->
      comments.append data['comment']
    send_comment: (comment, ticket_id) ->
      @perform 'send_comment', comment: comment, ticket_id: ticket_id
  $('#new_comment').submit (e) ->
    $this = $(this)
    textarea = $this.find('#comment_content')
    if $.trim(textarea.val()).length > 1
      App.global_chat.send_comment textarea.val(),
      comments.data('ticket-id')
      textarea.val('')
    e.preventDefault()
    return false