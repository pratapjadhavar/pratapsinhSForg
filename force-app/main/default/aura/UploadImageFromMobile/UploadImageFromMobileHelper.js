({
    fileUploadHelper:  function(component, attachFile){
    	var reader = new FileReader();
        reader.onload = function (e) {
            
            var image = new Image();
            image.src = e.target.result;
            
            image.onload = function() {
                console.log('===image.src====',image.src);
                console.log('===image.src====',image.src.match(/,(.*)$/)[1]);
                let attach = {};
                attach['fileName'] = attachFile.name;
                attach['contentType'] = attachFile.type;
                attach['Body'] = image.src.match(/,(.*)$/)[1];
                console.log('===attach====',attach);
                component.set("v.attachFile", attach);
            }
        }
        reader.readAsDataURL(attachFile);
	},
	fileUploadRotationAndCompressHelper : function(component, attachFile) {
        var reader = new FileReader();
        reader.onload = function (e) {
            
            var image = new Image();
            image.src = e.target.result;
            
            image.onload = function() {
                
                var canvas = document.createElement('canvas');
                // Set variables
                var ctx = canvas.getContext("2d");
                var exifOrientation = '';
                var width = this.width,
                    height = this.height;
                
                console.log(width);
                console.log(height);
                
                // Check orientation in EXIF metadatas
                EXIF.getData(this, function() {
                    var allMetaData = EXIF.getAllTags(this);
                    exifOrientation = allMetaData.Orientation;
                    console.log('Exif orientation: ' + exifOrientation);
                });
                
                // set proper canvas dimensions before transform & export
                if (jQuery.inArray(exifOrientation, [5, 6, 7, 8]) > -1) {
                    canvas.width = height;
                    canvas.height = width;
                } else {
                    canvas.width = width;
                    canvas.height = height;
                }
                
                // transform context before drawing image
                switch (exifOrientation) {
                    case 2:
                        ctx.transform(-1, 0, 0, 1, width, 0);
                        break;
                    case 3:
                        ctx.transform(-1, 0, 0, -1, width, height);
                        break;
                    case 4:
                        ctx.transform(1, 0, 0, -1, 0, height);
                        break;
                    case 5:
                        ctx.transform(0, 1, 1, 0, 0, 0);
                        break;
                    case 6:
                        ctx.transform(0, 1, -1, 0, height, 0);
                        break;
                    case 7:
                        ctx.transform(0, -1, -1, 0, height, width);
                        break;
                    case 8:
                        ctx.transform(0, -1, 1, 0, 0, width);
                        break;
                    default:
                        ctx.transform(1, 0, 0, 1, 0, 0);
                }
                
                // Draw img into canvas
                ctx.drawImage(this, 0, 0, width, height);
                var fileURL =  canvas.toDataURL(attachFile.type);//canvas.toDataURL(that.type,1.0); 
                
                
                var maxWidth = 960;
                var maxHeight = 960;
                var srcWidth = canvas.width;
                var srcHeight = canvas.height;
                
                var newWidth;
                var newHeight;
                
                var ratio = Math.min(maxWidth / srcWidth, maxHeight / srcHeight);
                
                newWidth = srcWidth*ratio;
                newHeight = srcHeight*ratio;
                
                var newCanvas = document.createElement('canvas');
                
                newCanvas.width = newWidth;
                newCanvas.height = newHeight;
                
                var context = newCanvas.getContext('2d');
                
                context.drawImage(canvas, 0, 0, newWidth, newHeight);
                
                var dataURL = newCanvas.toDataURL(attachFile.type);
                
                let attach = {};
                attach['fileName'] = attachFile.name;
                attach['contentType'] = attachFile.type;
                attach['Body'] = dataURL.match(/,(.*)$/)[1];
                console.log('===attach====',attach);
                component.set("v.attachFile", attach);
            }
        }
        reader.readAsDataURL(attachFile);
	},
    saveDataHelper: function(component, event, helper) {
        
        var attachInfo = component.get("v.attachFile");
        if(!attachInfo) return;
        console.log('====attachInfo===',attachInfo);
        
        component.set("v.loading", true);
        var action = component.get("c.createAttachment"); 
        action.setParams({
            "accountId" : component.get("v.recordId"),
            "strAttachJSON": JSON.stringify(attachInfo)
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS") {
                component.set("v.loading", false);
                helper.showToastHelper(component, 'Success!', 'success', 'Successfully updated.');
                $A.get("e.force:closeQuickAction").fire();
                $A.get('e.force:refreshView').fire(); 
            }
            else if (state === "ERROR") {
                component.set("v.loading", false);
                var errors = a.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                        helper.showToastHelper(component, 'Error!', 'error', errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                    helper.showToastHelper(component, 'Error!', 'error', "Unknown error");
                }
            }
            
        });
        $A.enqueueAction(action);
	},
    showToastHelper : function(component, title, type, message) {
         component.find('notifLib').showNotice({
            "variant": type,
            "header": title,
            "message": message,
            closeCallback: function() {
            }
        });
    }
})