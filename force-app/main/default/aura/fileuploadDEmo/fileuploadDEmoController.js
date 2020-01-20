({
    handleUploadFinished: function (cmp, event) {
        // Get the list of uploaded files
        var uploadedFiles = event.getParam("files");
        
      
        alert('documentId====>'+uploadedFiles[0].documentId);
        cmp.set("v.uploadedId",uploadedFiles[0].documentId);
        alert(uploadedFiles.documentId+"Files uploaded : " + uploadedFiles.length);
    }
})