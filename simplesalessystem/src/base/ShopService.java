package base;
//下面主要是导入网络服务所需要的一些类和异常类。
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.Executors;

public class ShopService extends HttpServlet{
    private ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    private double totalCost = 0.0;

    public void doPost(HttpServletRequest request,HttpServletResponse response)
            throws ServletException,IOException{
        //Servlet 要继承 HttpServlet 类，然后才能实现对用户的服务功能。
        //下面是参数定义
        String product;
        String decorator;
        String num;
        String description="";
        double price;
        int number = 1;

        //建立模型对象 bean，并把它置到请求头对象 request 中去
        ShopClientBean bean = new ShopClientBean();
        request.setAttribute("client", bean);

 /*建立饮料和配料的生产工厂，所有饮料和配料的实例均将通过它们获得。
 这里工厂的实现还是针对具体实现，实际上也可以通过接口 Factory 建立起与具
体工厂无关的实现。
 */
        Beverage beverage = null ;
        BeverageFactory factory = new BeverageFactory();
        DecoratorFactory deco = new DecoratorFactory();

        //从请求头中获得各个参数的值
        product = request.getParameter("product").trim();
        decorator = request.getParameter("decorator").trim();
        num = request.getParameter("num").trim();
        if(num != null && !num.equals(""))
            number = Integer.parseInt(num);

        if(product != null && product != ""){
            //获得饮料对象
            beverage = factory.getBeverage(product);
            description = beverage.getDescription();

            if(!(beverage instanceof NoBeverage) && !decorator.equals("") && number!=0){
                //获得配料对象
                beverage = deco.getDecorator(decorator, beverage);
                if(beverage instanceof NoDecorator)description = beverage.getDescription();
                else{
                    //获得饮料被装饰后（即加入配料后）的描述
                    description = beverage.getDescription()+" "+number+"份";

                    for(int i=1;i<number;i++){
                        //这个循环实现了添加多份配料
                        beverage = deco.getDecorator(decorator, beverage);
                    }
                }
            }
        }
        //获得饮料被装饰后（即加入配料后）的价格
        price = beverage.getCost();

        //把所有参数设定到模型 bean 中去
        bean.setProduct(product);
        bean.setDecorator(decorator);
        bean.setDescription(description);
        bean.setPrice(price);

        ServletContext context = getServletContext();

        // 生成20位序列号
        String sequenceNumber = new Random().ints(48, 122)
                .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
                .limit(20)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();

        // 获取当前时间
        String currentTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

        // 创建订单信息对象
        OrderInfo orderInfo = new OrderInfo(description, price, currentTime, sequenceNumber, "未支付", true);

        scheduleOrderStatusUpdates(orderInfo, context);

        // 获取订单信息集合
        List<OrderInfo> orders = (List<OrderInfo>) context.getAttribute("orders");
        if (orders == null) {
            orders = new ArrayList<>();
        }
        orders.add(orderInfo);

        // 更新ServletContext中的订单信息集合
        context.setAttribute("orders", orders);

        totalCost += bean.getPrice();

        HttpSession session = request.getSession();
        session.setAttribute("description", bean.getDescription());
        session.setAttribute("price", bean.getPrice());

        session.setAttribute("totalCost", totalCost);

        // 重定向到JSP页面
        //RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        //dispatcher.forward(request, response);

        response.sendRedirect("index.jsp");
    }
    private void scheduleOrderStatusUpdates(OrderInfo orderInfo, ServletContext context) {
        scheduler.schedule(() -> {
            if ("未支付".equals(orderInfo.getOrderStatus())) {
                orderInfo.setOrderStatus("超时");
            }
        }, 20, TimeUnit.SECONDS);

        // 支付后，立即更新订单状态为"准备中"
        //orderInfo.setOrderStatus("准备中");

        scheduler.schedule(() -> {
            if ("准备中".equals(orderInfo.getOrderStatus())) {
                orderInfo.setOrderStatus("已完成");
            }
        }, 40, TimeUnit.SECONDS);

        scheduler.schedule(() -> {
            orderInfo.setIsNew(false);
        }, 60, TimeUnit.SECONDS);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    public void destroy() {
        scheduler.shutdownNow();
        super.destroy();
    }
}
