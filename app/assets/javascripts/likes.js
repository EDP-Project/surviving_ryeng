$(function(){
  $('.like-btn').on('click', function(){
    $(this).toggleClass("clicked");
    // alert($(this).parent().data());
  });

  $('.dislike-btn').on('click', function(){
    $(this).toggleClass("clicked");
    // alert($(this).parent().data());
  });

});