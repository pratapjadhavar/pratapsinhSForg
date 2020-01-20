({
    onFileUploaded: function(component, event, helper) {
        var files = event.getSource().get("v.files");
        if(files.length >0){
            helper.fileUploadHelper(component, files[0]);
        }
    },
	onFileRotationAndCompress : function(component, event, helper) {
        var files = event.getSource().get("v.files");
        if(files.length >0){
            helper.fileUploadRotationAndCompressHelper(component, files[0]);
        }
	},
    save: function(component, event, helper) {
        helper.saveDataHelper(component, event, helper) ;
    },
    cancel: function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    } 
})