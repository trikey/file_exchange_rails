$ ->
    $.ajaxSetup
        headers:
            'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')

    $(".admin_delete").on 'click', ->
        url = $(this).attr("href")
        if (confirm("Вы уверены?"))
            $.ajax
                url: url,
                type: 'post',
                data:
                    _method: 'delete'
                success: (data) ->
                    window.location.reload()
        false

    $('.context').contextmenu()

    $("#folders").on 'click', '.delete_folder',  ->
        url = $(this).attr("data-url")
        if (confirm("Вы уверены?"))
            $.ajax
                url: url,
                type: 'post',
                data:
                    _method: 'delete'
                success: (data) ->
                    window.location.reload()
        false


    $("#folders").on 'click', '.rename_folder',  ->
        id = $(this).attr('data-id')
        $("#folder_#{id} .folder_name").hide()
        $("#folder_#{id} .folder_rename_input").show()
        $("#context-menu-#{id}").hide()
        false



    $("#folders").on 'click', '.folder_rename_input', (event) ->
        event.stopPropagation()
        false

    $(document).on 'blur', '.folder_rename_input', (e) ->
        $(document).click()

    $(document).on 'click', (e) ->
        if (!$(e.target).is('.folder_rename_input'))
            $("body").find(".folder_rename_input").not(":hidden").each ->
                id = $(this).attr('data-id')
                name = $(this).val()
                url = $(this).attr('data-url')
                method = $(this).attr('data-method')
                parent_id = $('#folders').attr('data-parent-id')
                $this = $(this)

                $.ajax
                    url: url,
                    type: 'post',
                    data:
                        _method: method
                        id: id
                        name: name,
                        description: name
                        parent_id: parent_id
                    success: (data) ->
                        $this.parents('.folder_container').replaceWith(data)
                        $('.context').contextmenu()

            $("#folders .folder_rename_input").hide()
            $('#folders .folder_name').show()


    $(".add_folder").on 'click', ->
        html = $('#clone_folder').html()
        $('#folders').append(html)
        $('#folders .folder_container').last().find('input').focus()
        false


    folderToMove = 0

    $('#folders').on 'click', '.move_folder', ->
        id = $(this).attr('data-id')
        folderToMove = id
        $("#context-menu-#{id}").hide()
        getTree()
        false

    fileToMove = 0

    $('#folders').on 'click', '.move_file', ->
        id = $(this).attr('data-id')
        fileToMove = id
        $("#context-menu-#{id}").hide()
        getTreeFiles()
        false


    curParentId = $('#folders').attr('data-parent-id');

    getTree = ->
        $.ajax
            url: $('#folders').attr('data-get-tree-url'),
            type: 'get',
            dataType: 'json'
        .done( (data) ->
            $('#tree').treeview
                data: data
                onNodeSelected: (event, data) ->
                    curParentId = data.id
            $('#treeModal').modal('show')
        )

    $('.select_category').click ->
        $.ajax
            url: "/folders/#{folderToMove}/edit",
            type: 'post',
            data:
                _method: 'put'
                id: folderToMove,
                parent_id: curParentId
                is_ajax: 'Y'
        .done( (data) ->
            window.location.reload()
        )
        false


    getTreeFiles = ->
        $.ajax
            url: $('#folders').attr('data-get-tree-url'),
            type: 'get',
            dataType: 'json'
        .done( (data) ->
            $('#treeFiles').treeview
                data: data
                onNodeSelected: (event, data) ->
                    curParentId = data.id
            $('#treeFilesModal').modal('show')
        )


    $('.select_category_for_file').click ->
        $.ajax
            url: "/files/#{fileToMove}/edit",
            type: 'post',
            data:
                _method: 'put'
                id: fileToMove,
                folder_id: curParentId
                is_ajax: 'Y'
        .done( (data) ->
            window.location.reload()
        )
        false

    $('.add_file').click ->
        $this = $(this)
        $.ajax
            url: $this.attr('data-url'),
            type: 'get',
        .done( (data) ->
            $('#file_add_contaier').html(data);
            $('#filesModal').modal('show')
        )
        false

    $(document).on 'click', '.save_file', ->
        if($("#file").val() == '')
            $('#file-errors').show()
            return false
        if($("#file_name").val() == '')
            $('#file-errors').show()
            return false
        $('#file-errors').hide()
        $('#file_upload_form input[name=folder_id]').val($('#folders').attr('data-parent-id'))
        $('#file_upload_form').submit()
        false


    $('body').on 'click', '.update_file', ->
        id = $(this).attr('data-id')
        $("#context-menu-#{id}").hide()
        $this = $(this)
        $.ajax
            url: $this.attr('data-url'),
            type: 'get',
        .done( (data) ->
            $('#file_add_contaier').html(data);
            $('#filesModal').modal('show')
        )
        false
#    $(document).on 'submit', "form#file_upload_form", ->
#        $('#file_upload_form input[name=folder_id]').val($('#folders').attr('data-parent-id'))
#        formData = new FormData($(this)[0])
#        $this = $(this)
#        $.ajax
#            url: $this.attr('action'),
#            type: 'POST',
#            data: formData,
#            async: false,
#            success: (data) ->
#                window.location.reload()
#            cache: false,
#            contentType: false,
#            processData: false
#        return false

    