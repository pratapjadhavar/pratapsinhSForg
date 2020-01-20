({
	validateItems : function(component) {
        var validItem = true;
        console.log('inseide helper validation===');
        //name
        var nameField = component.find("campName");
        var itemNameVal = nameField.get("v.value");
        if ($A.util.isEmpty(itemNameVal)) {
            validItem = false;
            nameField.set("v.errors", [{
                message: "Name cant be blank"
            }]);
        } else
            nameField.set("v.errors", null);

        //price
        var priceField = component.find("price");
        var priceVal = priceField.get("v.value");
        if (priceVal == 0) {
            validItem = false;
            priceField.set("v.errors", [{
                message: "price cant  be blank or zero"
            }]);
        } else
            priceField.set("v.errors", null);

        //Quantity
        var QuantityField = component.find("Quantity");
        var QuantityVal = QuantityField.get("v.value");
        if (QuantityVal == '' || QuantityVal == 0) {
            validItem = false;
            QuantityField.set("v.errors", [{
                message: "Quantity cant be blank or zero"
            }]);
        } else if (!QuantityVal.match(/^\d+$/)) {
            validItem = false;
            QuantityField.set("v.errors", [{
                message: "please enter only numric values"
            }]);
        } else
            QuantityField.set("v.errors", null);

        return (validItem);
    },

    createItem : function(component, itm) {
	console.log('H ci');

      var createEvnt=component.getEvent("addItem");
      createEvnt.setParams({"item": itm });
      createEvnt.fire();
    component.set("v.newItem",
                     { 'sobjectType': 'Camping_Item__c',
                    'Name': '',
                    'Packed__c': false,
                    'Price__c': 0,
                    'Quantity__c': 0});
      console.log('event fired...');
    

    }
})