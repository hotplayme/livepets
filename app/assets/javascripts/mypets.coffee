$ ->
  $(document).on 'change', '#breed_type', (evt) ->
    $.ajax '../../pet/update_breeds',
      type: 'GET'
      dataType: 'script'
      data: {
        breed_type: $("#breed_type option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")

$ ->
  $('#mypet_pet_attachment').fileupload(
    method: 'PUT',
    url: '/pet/image_create',
    multiple: true
    progressall: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)
      $('.vote-list-progress-bg').show()
      $('.vote-list-progress-state').width(progress + '%')
      return
  )