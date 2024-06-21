package base;
public class Coffee extends Beverage {
    //这里是 Coffee 本身的描述和价格
    public Coffee(){
        description = "Coffee Beverage";
    }
    public double getCost() {
        return 2;
    }
}