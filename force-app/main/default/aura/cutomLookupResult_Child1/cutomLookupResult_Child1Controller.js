({
 selectContact : function(component, event, helper){ 
 // get the selected Contact from list 
 var getSelectContact = component.get("v.oContact");
  
 // call the event 
 var compEvent = component.getEvent("oSelectedContactEvent");
 console.log("getSelecteContact"+ JSON.stringify(getSelectContact));
  
 // set the Selected contact to the event attribute. 
 compEvent.setParams({"contactByEvent" : getSelectContact }); 
  
 // fire the event 
 compEvent.fire();
 },
})