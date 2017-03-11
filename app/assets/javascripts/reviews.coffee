$ ->
  $('#review_review_attachments').fileupload(
    method: 'PUT',
    url: '/reviews/image_create',
    multiple: true
    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('.vote-list-progress-bg').show()
      $('.vote-list-progress-state').width(progress + '%')
      return
  )
