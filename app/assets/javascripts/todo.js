$(document).ready(function(){
$("#sortable").sortable();
$("#sortable").disableSelection();

countTodos();

// all done btn
$("#checkAll").click(function(){
    AllDone();
});

//create todo
$('.add-todo').on('keypress',function (e) {
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
                $("#success_notice").html("<div class='alert alert-success fade in'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>Finished</strong></div>");
            }
        });
        done(doneItem);
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
            $("#success_notice").html("<div class='alert alert-danger fade in'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>Removed</strong></div>");
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
function createTodo(text){
    var markup = '<li class="ui-state-default"><div class="checkbox"><label><input type="checkbox" value="" />'+ text +'</label></div></li>';
        $.ajax({
            url: '/tasks',
            type: 'POST',
            dataType:'json',
            data: {task: {todo: text}},
            success: function (response) {
                $("#success_notice").html("<div class='alert alert-success fade in'><a href='#' class='close' data-dismiss='alert'>&times;</a><strong>Added</strong></div>");
            }
        });
    $('#sortable').append(markup);
    $('.add-todo').val('');
}


//mark task as done
function done(doneItem){
    var done = doneItem;
    var markup = '<li>'+ done +'<button class="btn btn-default btn-xs pull-right  remove-item"><span class="glyphicon glyphicon-remove"></span></button></li>';
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