package base;
public class MilkDecorator extends Decorator {
    Beverage beverage;
    public MilkDecorator(Beverage beverage){
        this.beverage = beverage;
    }

    public String getDescription() {
        return beverage.getDescription()+" 和 Milk";
    }
    public double getCost() {
        return beverage.getCost()+0.75;
    }
}