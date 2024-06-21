package base;
//添加这个装饰者类是为了使访问统一，处理各种非法请求
public class NoDecorator extends Decorator {
    String description = "没有您所点的配料，请重新点(milk 或 ice)。";
    public String getDescription() {
        return this.description;
    }
    public double getCost() {
        return 0;
    }
}