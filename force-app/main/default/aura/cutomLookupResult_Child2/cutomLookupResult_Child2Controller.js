({
 selectContact: function(component, event, helper) {
 
 // call the event 
 var cmpEvent = component.getEvent("myEvent");
 
 console.log("getSelecteContact"+ JSON.stringify(component.get("v.con")));
 
 // Pass the selected result(i.e Contact) value
 cmpEvent.setParams({
 "contactByEvent": component.get("v.con")
 });
 
// Fire an Event
 cmpEvent.fire();
 }
})