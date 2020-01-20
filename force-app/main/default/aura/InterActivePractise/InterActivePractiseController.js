({
	handleClick : function(component, event, helper) {
		component.set("v.message",event.getSource().get("v.label"));
		 
		
	},
	handleClick2 : function(component, event, helper) {
		var checkbox = component.get("v.item",true);	
		console.log('item data---'+checkbox);	
	}
})