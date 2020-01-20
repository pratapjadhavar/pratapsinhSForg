({
    saveExpense: function(component, expense, callback) {
    var action = component.get("c.saveExpense");
    action.setParams({
        "expense": expense
    });
    if (callback) {
        action.setCallback(this, callback);
    }
    $A.enqueueAction(action);
},

createExpense: function(component, expense) {
    this.saveExpense(component, expense, function(response){
        var state = response.getState();
        if (component.isValid() && state === "SUCCESS") {
            var expenses = component.get("v.expenses");
            expenses.push(response.getReturnValue());
            component.set("v.expenses", expenses);
        }
    });
},

updateExpense: function(component, expense) {
    this.saveExpense(component, expense);
},

    validateExpenseForm: function(component) {
    // Simplistic error checking
    var validExpense = true;

    // Name must not be blank
    var nameField = component.find("expname");
    var expname = nameField.get("v.value");
    if ($A.util.isEmpty(expname)){
        validExpense = false;
        nameField.set("v.errors", [{message:"Expense name can't be blank."}]);
    }
    else {
        nameField.set("v.errors", null);
    }

    // Amount must be set, must be a positive number
    var amtField = component.find("amount");
    var amt = amtField.get("v.value");
    if ($A.util.isEmpty(amt) || isNaN(amt) || (amt <= 0.0)){
        validExpense = false;
        amtField.set("v.errors", [{message:"Enter an expense amount."}]);
    }
    else {
        // If the amount looks good, unset any errors...
        amtField.set("v.errors", null);
    }
    
    return(validExpense);
}
})