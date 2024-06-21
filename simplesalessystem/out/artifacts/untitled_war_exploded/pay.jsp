<%@ page contentType="text/html;Charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="base.OrderInfo" %>
<%@ page import="java.util.List" %>
<%
    String orderNumber = request.getParameter("order");
    ServletContext context = request.getServletContext();
    List<OrderInfo> orders = (List<OrderInfo>) context.getAttribute("orders");
    OrderInfo currentOrder = null;
    if (orders != null && orderNumber != null) {
        for (OrderInfo order : orders) {
            if (orderNumber.equals(order.getSequenceNumber())) {
                currentOrder = order;
                break;
            }
        }
    }
%>
<html>
<head>
    <title>支付</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script>
        function completePayment(paymentMethod) {
            <% if (currentOrder != null) { %>
            <% currentOrder.setOrderStatus("准备中"); %>
            // 更新ServletContext中的订单信息集合
            context.setAttribute("orders", orders);
            <% } %>
            alert(paymentMethod + " 支付成功！");
            window.location.href = "index.jsp";
        }
    </script>
</head>
<body>
<h1>支付订单</h1>
<% if (currentOrder != null) { %>
<p>订单号：<%= currentOrder.getSequenceNumber() %></p>
<p>订单状态：<%= currentOrder.getOrderStatus() %></p>
<div>
    <img src="wechat.jfif" alt="微信支付" class="img" onchange="completePayment('微信')" h>
    <img src="alipay.jfif" alt="支付宝" class="img" onchange="completePayment('支付宝')" >
</div>
<% } else { %>
<p>订单不存在或已支付。</p>
<% } %>
<form action="index.jsp" method="get">
    <input type="submit" value="返回首页" class="return-button">
</form>
</body>
</html>