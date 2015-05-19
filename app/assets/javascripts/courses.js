$(function(){

  $('#new-guide-trigger').on('click', function(){
    $('#new-guide-modal').modal('show');
  })

  $('#edit-guide-trigger').on('click', function(){
    $('#edit-guide-modal').modal('show');
  })

  $('#new-attachment-trigger').on('click', function(){
    $('#new-attachment-modal').modal('show');
  })

  $('.froala-textarea').editable({
    inlineMode: false,
    minHeight: 600
  });

  //$('[data-toggle="tooltip"]').tooltip();

  $('body').tooltip({
    selector: '[data-toggle=tooltip]'
  });

    var $btnSets = $('#responsive'),
    $btnLinks = $btnSets.find('a');
 
    $btnLinks.click(function(e) {
        e.preventDefault();
        $(this).siblings('a.active').removeClass("active");
        $(this).addClass("active");
        var index = $(this).index();
        $("div.user-menu>div.user-menu-content").removeClass("active");
        $("div.user-menu>div.user-menu-content").eq(index).addClass("active");
    });

    $("[rel='tooltip']").tooltip();    


});