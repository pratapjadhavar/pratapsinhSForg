({
  
    doInit: function(component, event, helper) {

        var action = component.get("c.getItems");
        console.log('asdasd');

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === 'SUCCESS') {
                component.set("v.items", response.getReturnValue());
            } else
                console.log("failed with state...!" + state);
        });

        $A.enqueueAction(action);
    },
      handleAddItem : function(component, event, helper) {
       console.log('main C handle');
          
            var newitems = event.getParam("item");
            
           var action = component.get("c.saveItem");
        action.setParams({
            "itm": newitems
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                var itemss = component.get("v.items");
                itemss.push(response.getReturnValue());
                component.set("v.items", itemss);
            }
        });

        $A.enqueueAction(action);
    }
    
})