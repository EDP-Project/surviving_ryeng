$(function(){

  $('#new-guide-trigger').on('click', function(){
    $('#new-guide-modal').modal('show');
  })

  $('#new-attachment-trigger').on('click', function(){
    $('#new-attachment-modal').modal('show');
  })

  $('.froala-textarea').editable({inlineMode: false});

  $('[data-toggle="tooltip"]').tooltip();



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
 
    $('.view').hover(
        function(){
            $(this).find('.caption').slideDown(250); //.fadeIn(250)
        },
        function(){
            $(this).find('.caption').slideUp(250); //.fadeOut(205)
        }
    );


});