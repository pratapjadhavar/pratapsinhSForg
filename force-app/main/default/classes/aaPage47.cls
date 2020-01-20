public class aaPage47 {
    public String MyValue1 { get; set; }
    public String MyValue2 { get; set; }
    public account aa{set;get;}
    public aaPage47(){
        aa=[select id, name from account limit 1];
    }
}