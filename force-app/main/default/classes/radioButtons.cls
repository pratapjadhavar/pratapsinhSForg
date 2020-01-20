public class radioButtons {  
 public string SelectedValue{set;get;}  
 //integer to store the Result  
 public integer num{set;get;}  
 //list which stores the size of pageblock table to iterates radio buttons based on list size  
  public List<row> rows { get; set; }  
   //constructor  
   public radioButtons(){  
   num = 0;  
    rows = new List<Row>();  
    for(integer i=0;i<=4;i++){  
     rows.add(new row('5', '5'));  
     }  
   }  
   //method which adds the selected value to num integer  
   public void addaction(){  
   string number1 = system.currentPageReference().getParameters().get('number');  
   system.debug('Number::::::::::'+number1);  
   num = num+integer.valueof(number1);  
   }  
   //method which return the values and labels into apex select options  
    public List<SelectOption> getItems() {  
     List<SelectOption> options = new List<SelectOption>();  
     options.add(new SelectOption('5','5'));  
     options.add(new SelectOption('10','10'));  
     return options;  
   }  
   //inner class  
    public class Row {  
     public String Value { get; set; }  
     public String Label { get; set; }  
     public Boolean isChecked { get; set; }  
     public Row(String Value, String Label) {  
       this.Value = Value;  
       this.Label = Label;  
     }   
   }  
 }