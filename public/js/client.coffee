$ ->
    $(document).on 'click', '.download_file', ->
        window.location = $(this).attr('data-download-href')
        false

    $("#folders").on 'click', '.folder_link',  ->
        window.location = $(this).attr('data-url')
        false