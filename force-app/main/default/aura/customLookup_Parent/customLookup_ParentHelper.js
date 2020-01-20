({
searchHelper : function(component,event,getInputkeyWord) {
// call the apex class method
component.set("v.Showspinner", true);
var action = component.get("c.fetchContact");
// set param to method
action.setParams({
'searchKeyWord': getInputkeyWord
});
// set a callBack
action.setCallback(this, function(response) {
component.set("v.Showspinner", false);
var state = response.getState();
if (state === "SUCCESS") {
var storeResponse = response.getReturnValue();
// if storeResponse size is equal 0 ,display No Result Found... message on screen.
 
if (storeResponse.length == 0) {
component.set("v.Message", 'No Result Found...');
} else {
component.set("v.Message", '');
}
 
// Set the boolean for hiding and showing the dropdown list and popup window
var Ddlist = component.get("v.Dropdownlist");
 
// set searchResult list with return value from server
if(Ddlist == false){
 
// set searched result to show in the table
component.set("v.SearchedResult", storeResponse);
}
 
else{
 
component.set("v.listOfSearchRecords", storeResponse);
 
}
 
}
 
});
// enqueue the Action
$A.enqueueAction(action);
 
}
})