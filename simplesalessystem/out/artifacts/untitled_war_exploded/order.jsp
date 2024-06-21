<%--
  Created by IntelliJ IDEA.
  User: 14537
  Date: 2024/6/21
  Time: 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;Charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="java.util.List" %>
<%@ page import="base.OrderInfo" %>
<%
    ServletContext context = request.getServletContext();
    List<OrderInfo> orders = (List<OrderInfo>) context.getAttribute("orders");
%>
<html>
<head>
    <title>全部订单</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<h1>全部订单</h1>
<table class="menu-table">
    <tr>
        <th>订单描述</th>
        <th>价格</th>
        <th>订单时间</th>
        <th>序列号</th>
        <th>订单状态</th>
        <th>操作</th>
    </tr>
    <% if (orders != null && !orders.isEmpty()) {
        for (OrderInfo order : orders) { %>
    <tr>
        <td><%= order.getDescription() %></td>
        <td><%= order.getPrice() %>元</td>
        <td><%= order.getOrderTime() %></td>
        <td><%= order.getSequenceNumber() %></td>
        <td><%= order.getOrderStatus() %></td>
        <td>
            <% if ("未支付".equals(order.getOrderStatus())) { %>
            <a href="pay.jsp?order=<%= order.getSequenceNumber() %>">支付</a>
            <% } %>
        </td>
    </tr>
    <% }
    } else { %>
    <tr>
        <td colspan="6">暂未购买</td>
    </tr>
    <% } %>
</table>
<form action="index.jsp" method="get">
    <input type="submit" value="返回首页" class="return-button">
</form>
</body>
</html>