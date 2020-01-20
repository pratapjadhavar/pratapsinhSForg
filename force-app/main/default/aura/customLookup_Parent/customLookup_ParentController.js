({
 // function called on keyup in the search bar
 keyPressController : function(component, event, helper) {
 // get the search Input keyword
 var getInputkeyWord = component.get("v.SearchKeyWord");
 // check if getInputKeyWord size id more then 0 then open the lookup result List and 
 
 // else close the lookup result List part.
 if( getInputkeyWord.length > 0 ){
 var forOpen = component.find("searchRes");
 $A.util.addClass(forOpen, 'slds-is-open');
 $A.util.removeClass(forOpen, 'slds-is-close');
 
 // Calling Helper function
 helper.searchHelper(component,event,getInputkeyWord);
 }
 else{
 component.set("v.listOfSearchRecords", null );
 var forclose = component.find("searchRes");
 $A.util.addClass(forclose, 'slds-is-close');
 $A.util.removeClass(forclose, 'slds-is-open');
 }
 
 },
 
 // function for clear the Record Selection
 clear :function(component,event,heplper){
 
 var pillTarget = component.find("lookup-pill");
 $A.util.addClass(pillTarget, 'slds-hide');
 $A.util.removeClass(pillTarget, 'slds-show');
 
 var lookUpTarget = component.find("lookupField");
 $A.util.addClass(lookUpTarget, 'slds-show');
 $A.util.removeClass(lookUpTarget, 'slds-hide');
 
 component.set("v.SearchKeyWord",null);
 component.set("v.listOfSearchRecords", null );
 
var lookUpTarget =component.find("lookupField");
 $A.util.addClass(lookUpTarget, 'slds-show');
 $A.util.removeClass(lookUpTarget, 'slds-hide');
 
component.set("v.Dropdownlist" , true);
 
 },
 
 // This function call when the end User Select any record from the result list.
 handleComponentEvent : function(component, event, helper) {
 
// get the selected Contact record from the COMPONETN event
 var selectedContactGetFromEvent = event.getParam("contactByEvent");
 
 component.set("v.selectedRecord" , selectedContactGetFromEvent);
 console.log(component.get("v.selectedRecord"));
 
 var forclose = component.find("lookup-pill");
 $A.util.addClass(forclose, 'slds-show');
 $A.util.removeClass(forclose, 'slds-hide');
 
 var forclose = component.find("searchRes");
 $A.util.addClass(forclose, 'slds-is-close');
 $A.util.removeClass(forclose, 'slds-is-open');
 
 var lookUpTarget =component.find("lookupField") ;
 $A.util.addClass(lookUpTarget, 'slds-hide');
 $A.util.removeClass(lookUpTarget, 'slds-show');
 
 },
 
 // automatically call when the component is done waiting for a response to a server request.
 hideSpinner : function (component, event, helper) {
 var spinner = component.find('spinner');
 var evt = spinner.get("e.toggle");
 evt.setParams({ isVisible : false });
 evt.fire();
 },
 
// automatically call when the component is waiting for a response to a server request.
 showSpinner : function (component, event, helper) {
 var spinner = component.find('spinner');
 var evt = spinner.get("e.toggle");
 evt.setParams({ isVisible : true });
 evt.fire();
 },
 
// On Press of icon Modal-Popup will open
 SearchContact : function (component, event, helper) {
 
component.set("v.Dropdownlist" , false);
 
$A.util.removeClass(component.find("ContactLookup"), "visibilityNO");
 $A.util.removeClass(component.find("popUpBackgroundId1"), "visibilityNO");
 
component.set("v.cssStyle", ".forceStyle .viewport .oneHeader {z-index:0; }.slds-global-header_container {position: static;} .forceStyle.desktop .viewport{overflow:hidden}");
 component.set("v.Showspinner" , true);
 
var action = component.get("c.getContacts1");
 action.setCallback(this, function(data) {
 component.set("v.Showspinner" , false);
 component.set("v.SearchedResult", data.getReturnValue());
 console.log('contactfirstname' + JSON.stringify(component.get("v.SearchedResult")));
 });
 
$A.enqueueAction(action);
 },
 
// For hiding the Modal-Popup.
 HideContactPopup : function (component, event, helper) {
 
component.set("v.cssStyle", "");
 $A.util.addClass(component.find("ContactLookup"), "visibilityNO");
 $A.util.addClass(component.find("popUpBackgroundId1"), "visibilityNO");
 
// Setting boolean as true for dropdown list
 component.set("v.Dropdownlist" , true);
 
},
 
// Place the selected contact to output box
 GetSelectedCont : function (component, event, helper) {
 
component.set("v.cssStyle", "");
 
 //Handle event from child component of who will send the particular selected contact
 var cont = event.getParam("contactByEvent");
 
 component.set("v.selectedRecord", cont);
 var cc = component.get("v.selectedRecord")
 
 // Hiding the dropdown list component when selecting the record from lookup window
 var forclose = component.find("lookup-pill");
 $A.util.addClass(forclose, 'slds-show');
 $A.util.removeClass(forclose, 'slds-hide');
 
// Setting attribute used in search bar as null
 component.set("v.SearchKeyWord" , '');
 
// Hiding the search bar on selection of one value
 var lookUpTarget =component.find("lookupField") ;
 $A.util.addClass(component.find("lookupField"), 'slds-hide');
 
 $A.util.addClass(component.find("ContactLookup"), "visibilityNO");
 $A.util.addClass(component.find("popUpBackgroundId1"), "visibilityNO");
 
$A.util.removeClass(component.find("searchRes"), "slds-is-open");
 $A.util.addClass(component.find("searchRes"), "slds-is-close");
 
var lookUpTarget =component.find("lookupField") ;
 $A.util.addClass(lookUpTarget, 'slds-hide');
 $A.util.removeClass(lookUpTarget, 'slds-show');
 
}
 
})