$ ->
  $(document).on 'change', '#countries_select', (evt) ->
    $.ajax '../users/update_cities',
      type: 'GET'
      dataType: 'script'
      data: {
        country_id: $("#countries_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")

$ ->
  $('#avatar').fileupload(
    method: 'PUT',
    url: '../../users/update_avatar'
  )