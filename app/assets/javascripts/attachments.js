// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
  // disable auto discover
  Dropzone.autoDiscover = false;
 

  var dropzone = new Dropzone (".dropzone", {
    maxFilesize: 25, // Set the maximum file size to 256 MB
    paramName: "attachment[upload]", // Rails expects the file upload to be something like model[field_name]
    addRemoveLinks: true, // Don't show remove links on dropzone itself.
    autoProcessQueue
  }); 

  dropzone.on("success", function(file) {
    this.removeFile(file)
    $.getScript("/images")
  })
});