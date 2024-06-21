package base;
public class IceDecorator extends Decorator {

    Beverage beverage;
    public IceDecorator(Beverage beverage){
        this.beverage = beverage;
    }

    public String getDescription() {
        return beverage.getDescription()+" 和 Ice";
    }
    public double getCost() {
        return beverage.getCost()+0.5;
    }
}