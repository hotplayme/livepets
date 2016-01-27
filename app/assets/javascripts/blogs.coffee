$ ->
  $('#blog_blog_attachment').fileupload(
    method: 'PUT',
    url: '/blogs/image_create',
    multiple: true
    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('.vote-list-progress-bg').show()
      $('.vote-list-progress-state').width(progress + '%')
      return
  )

$ ->
  $('.feed-user-block').infinitePages
    debug: true
    buffer: 100
    loading: ->
      $(this).html('<center><img src="/images/480.gif"></center>')
    error: ->
      $(this).button('Произошла ошибка. Повторите запрос позже...')