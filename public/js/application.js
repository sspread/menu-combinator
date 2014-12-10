$(document).ready(function() {

  $("#upload_form").on("submit", function() {
    $("#upload_messages").append("<%= partial(:'partials/upload_error')%>")
  });

});
