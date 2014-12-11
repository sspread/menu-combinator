$(function() {
  $("#upload_form").on("submit", function() {
    var fileValidator;
    fileValidator = new FileValidator();
    fileValidator.parseInput($("#upload_input"));
    if (fileValidator.validateFiletype()) {
      fileValidator.showLoading($("#upload_messages"));
    } else {
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

  showLoading: function(el) {
    $(el).html("<p class='success'>Loading "+this.fileName+"...</p>")
  },

  showFailure: function(el) {
    if (this.fileName) {
      $(el).html("<p class='error'>Failed to upload: "+this.fileName+"We need a \.csv or \.txt file!</p>")
    } else {
      $(el).html("<p class='error'>Forgetting the file?</p>")
    }
  }

}