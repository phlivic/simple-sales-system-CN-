package base;

public class SugarDecorator extends Decorator{
    Beverage beverage;
    public SugarDecorator(Beverage beverage){
        this.beverage = beverage;
    }

    public String getDescription() {
        return beverage.getDescription()+" 和 Sugar";
    }
    public double getCost() {
        return beverage.getCost()+0.25;
    }
}
