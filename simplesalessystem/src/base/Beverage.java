package base;
public abstract class Beverage {
    String description = "Unknown Beverage.";
    //decription 用来描述当前的饮料
    public String getDescription(){
        return description;
    }
    //此方法用来计算饮料的费用
    public abstract double getCost();
}