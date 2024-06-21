package base;

public class BeverageFactory implements Factory{

    private String beverageName;
    private Beverage beverage;

    public Beverage getBeverage(String beverageName){
        this.beverageName = beverageName;
        if(beverageName.equals("coca"))
            beverage = new Coca();
        else if(beverageName.equals("coffee"))
            beverage = new Coffee();
        else if(beverageName.equals("tea"))
            beverage = new Tea();

            //这里的 NoBeverage 对象可以处理各种其他情况，具体实现见“非法请求处理”
        else beverage = new NoBeverage();

        return beverage;
    }
}