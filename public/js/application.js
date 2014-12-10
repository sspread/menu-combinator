$(function() {
  $("#upload_form").on("submit", function() {
    var fileValidator;
    fileValidator = new FileValidator();
    fileValidator.parseInput($("#upload_input"));
    if (!fileValidator.validateFiletype()) {
      event.preventDefault();
      fileValidator.showFailure($("#upload_messages"));
    }
  });
});

function FileValidator() {
  this.fileType;
  this.fileName;
}

FileValidator.prototype = {
  parseInput: function(input) {
    var filePath, nameIndex, typeIndex;
    filePath = input.val();
    nameIndex = filePath.lastIndexOf("\\")+1;
    this.fileName = filePath.substr(nameIndex);
    typeIndex = this.fileName.lastIndexOf("\.");
    this.fileType = this.fileName.substr(typeIndex);
  },

  validateFiletype: function() {
    if (this.fileType === ".csv" || this.fileType === ".txt") {
      return true
    } else {
      return false
    }
  },

  // showSuccess: function(el) {
  //   $(el).html("<p class='success'>Successfully uploaded "+this.fileName+"</p>")
  // },

  showFailure: function(el) {
    $(el).html("<p class='error'>Failed to upload: "+this.fileName+"<br> We need a \.csv or \.txt file!</p>")
  }

}