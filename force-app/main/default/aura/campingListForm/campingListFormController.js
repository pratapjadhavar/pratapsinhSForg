({
	submitForm : function(component, event, helper) {
		if (helper.validateItems(component)) {
           console.log('C sub');
            var newitems = component.get("v.newItem");
            
           
            helper.createItem(component, newitems);
        } 
	}
})