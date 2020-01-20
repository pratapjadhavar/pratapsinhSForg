({
    fetchAccountDetails : function(component, event, helper) {
        // set table columns in variable
        var tableColumns = [
            {
                "label": "Important Account",
                "fieldName": "VIP_Account__c",
                "cellAttributes": {
                    "class": {
                        "fieldName": "showClass"
                    },
                    "iconName": {
                        "fieldName": "displayIconName"
                    }
                }
            },
            {
                "label": "Account Name",
                "fieldName": "linkName",
                "type": "url",
                "typeAttributes": {
                    "label": {
                        "fieldName": "Name"
                    },
                    "target": "_blank"
                },
                "cellAttributes": {
                    "class": {
                        "fieldName": "showClass"
                    }
                }
            },
            {
                "label": "Industry",
                "fieldName": "Industry",
                "type": "picklist",
                "cellAttributes": {
                    "class": {
                        "fieldName": "showClass"
                    }
                }
            },
            {
                "label": "Account Type",
                "fieldName": "Type",
                "type": "picklist",
                "cellAttributes": {
                    "class": {
                        "fieldName": "showClass"
                    }
                }
            }
        ];
        // set tableCol attribute with table columns
        component.set('v.tableCol', tableColumns);
        
        // call server side apex method to fetch account records
        var action = component.get("c.getAccounts");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                // store the account list in records variable
                var records = response.getReturnValue();
                // iterate each records with forEach loop
                records.forEach(function(record){ 
                    if(typeof record.Id != 'undefined'){ 
                        // based on VIP Account field value set the icon and style class to each record 
                        // https://www.lightningdesignsystem.com/icons/#utility 
                        if(record.VIP_Account__c){
                            record.showClass = (record.VIP_Account__c === true ? 'redcolor' : 'blackcolor');
                            record.displayIconName = 'utility:check';  
                        }
                        else{
                            record.showClass = (record.VIP_Account__c === false ? 'blackcolor' : 'redcolor');
                            record.displayIconName = 'utility:close';     
                        }
                        // set the record link with record id  
                        record.linkName = '/'+record.Id;   
                        record.Name='\n dsssssssssssssssjss \nfdgdfg';
                        console.log(' record==='+ record.Name);
                    }
                });
                // after the loop set the updated account records on "accountList" aura attribute
                console.log('records[0].Name=='+records[0].Name);
                component.set("v.accountList", records);
            }
        });
        $A.enqueueAction(action);
    }
})