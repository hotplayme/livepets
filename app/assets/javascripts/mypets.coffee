$ ->
  $(document).on 'change', '#breed_type', (evt) ->
    $.ajax '../pet/update_breeds',
      type: 'GET'
      dataType: 'script'
      data: {
        breed_type: $("#breed_type option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")