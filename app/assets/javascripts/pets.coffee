$(document).on 'change', '#breed', ->
  if $(this).prop('checked') == false
    show_indie = $(this).val()
  else
    show_indie = 'nothing'
  $.ajax
    url: '/pets/filter'
    type: 'post'
    dataType: 'script'
    data: show_indie: show_indie
    success: ->
      console.log(show_indie)
      console.log 'filtered'
    error: ->
      console.log 'error with ajax'