$(document).ready(function(){
    $("#sortable").sortable();
    $("#sortable").disableSelection();

    countTodos();

    // all done btn
    $("#checkAll").click(function(){
        AllDone();
    });

    //create todo
    /*$('.add-todo').on('keypress',function (e) {
        e.preventDefault
        if (e.which == 13) {
            if($(this).val() != ''){
            var todo = $(this).val();
            createTodo(todo); 
            countTodos();
            }else{
                // some validation
            }
        }
    });*/

    //create todo
    $('#save_data').click(function(e) {
        e.preventDefault
        var todo = $('.add-todo').val();
        var due = $('.due-date').val();
        if(todo != '' && due != ''){
            var todo = $('.add-todo').val();
            var due = $('.due-date').val();
            last_id = $('#last_id').val();
            // last_id = last_id + 1;
            createTodo(todo,due,last_id); 
            countTodos();
        }else{
            var types = [BootstrapDialog.TYPE_DANGER];
            $.each(types, function(index, type){
                BootstrapDialog.show({
                    type: type,
                    title: 'Alert',
                    message: 'Please enter data',
                    draggable: true
                });     
            });
        }
    });


    // mark task as done
    $('.todolist').on('change','#sortable li input[type="checkbox"]',function(){
        if($(this).prop('checked')){
            var doneItem = $(this).parent().parent().find('label').text();
            $(this).parent().parent().parent().addClass('remove');
            var id = $(this).val();
            $.ajax({
                url: '/tasks/' + id,
                type: 'PUT',
                dataType:'json',
                data: {task: {finished: true}},
                success: function (response) {
                    // $("#success_notice").html("<div class='alert alert-success fade in'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>Finished</strong></div>");
                    var types = [BootstrapDialog.TYPE_SUCCESS];
                    $.each(types, function(index, type){
                        BootstrapDialog.show({
                            type: type,
                            title: 'SUCCESS',
                            message: 'You have finished your task',
                            draggable: true
                        });     
                    });
                }
            });
            done(doneItem, id);
            countTodos();
        }
    });

    //delete done task from "already done"
    $('.todolist').on('click','.remove-item',function(){
        var id = $(this).val();
        $.ajax({
            url: '/tasks/' + id,
            type: 'PUT',
            dataType:'json',
            data: {task: {published: false}},
            success: function (response) {
                // $("#success_notice").html("<div class='alert alert-danger fade in'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>Removed</strong></div>");
                var types = [BootstrapDialog.TYPE_DANGER];
                $.each(types, function(index, type){
                    BootstrapDialog.show({
                        type: type,
                        title: 'Removed',
                        message: 'You have removed your task from this list',
                        draggable: true
                    });     
                });
            }
        });
        removeItem(this);
    });

    // count tasks
    function countTodos(){
        var count = $("#sortable li").length;
        $('.count-todos').html(count);
    }

  //create task
    function createTodo(text,date, last_id){
        last_id++;
        var markup = '<li class="ui-state-default"><div class="checkbox"><label><input type="checkbox" value="'+ last_id +'" />'+ text + ' <span class="task-date" title="Due Date">' + date +'</span></label></div></li>';
        $.ajax({
            url: '/tasks',
            type: 'POST',
            dataType:'json',
            data: {task: {todo: text, expire: date}},
            success: function (response) {
                // $("#success_notice").html("<div class='alert alert-success fade in'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>Added</strong></div>");
                var types = [BootstrapDialog.TYPE_SUCCESS];
                $.each(types, function(index, type){
                    BootstrapDialog.show({
                        type: type,
                        title: 'SUCCESS',
                        message: 'Successfully created your data',
                        draggable: true
                    });     
                });
            }
        });
        $('#sortable').append(markup);
        $('.add-todo, .due-date').val('');
    }


    //mark task as done
    function done(doneItem, id){
        var done = doneItem;
        var id = id;
        var markup = '<li>'+ done +'<button value='+ id +' data-toggle="tooltip" title="Done" class="btn btn-danger btn-xs pull-right  remove-item"><span class="glyphicon glyphicon-remove"></span></button></li>';
        $('#done-items').append(markup);
        $('.remove').remove();
    }

    //mark all tasks as done
    function AllDone(){
        var myArray = [];

        $('#sortable li').each( function() {
            myArray.push($(this).text());   
        });
      
        // add to done
        for (i = 0; i < myArray.length; i++) {
            $('#done-items').append('<li>' + myArray[i] + '<button class="btn btn-default btn-xs pull-right  remove-item"><span class="glyphicon glyphicon-remove"></span></button></li>');
        }
      
        // myArray
        $('#sortable li').remove();
        countTodos();
    }

    //remove done task from list
    function removeItem(element){
        $(element).parent().remove();
    }
});