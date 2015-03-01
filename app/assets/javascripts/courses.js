$(function(){

  $('#new-guide-trigger').on('click', function(){
    $('#new-guide-modal').modal('show');
  })

  $('#new-attachment-trigger').on('click', function(){
    $('#new-attachment-modal').modal('show');
  })

  $('.froala-textarea').editable({inlineMode: false});

});