({
    doSearchUser: function(component) {
        var action = component.get("c.searchUser");
        action.setParams({
            "userId": component.get("v.users.id")
        });
         action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
               component.get("v.users", response.getReturnValue());
 				alert(component.get("v.users"));
            } else {
                console.log(response.getError());
            }
        });
        $A.enqueueAction(action);
    },
  /*  doSearchContact: function(component) {
        var action = component.get("c.searchUser");
        action.setParams({
            "contact": component.get("v.contacts.id")
        });
    }*/
})