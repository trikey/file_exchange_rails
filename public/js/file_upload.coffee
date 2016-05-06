$ ->
    $.ajaxSetup
        headers:
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')

    $('form#file_upload_form').ajaxForm({
        beforeSend: ->
            $('#status').empty()
            percentVal = '0%'
            $('.bar').width(percentVal)
            $('.bar').text(percentVal)
        uploadProgress: (event, position, total, percentComplete) ->
            percentVal = percentComplete + '%'
            $('.bar').width(percentVal)
            $('.bar').text(percentVal)
        complete: (xhr) ->
            $("form#file_upload_form").trigger("reset")
            $('#status').html(xhr.responseText)
            $('.close_file_upload').click ->
                window.location.reload()
    })