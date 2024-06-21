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
    <title>ȫ������</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<h1>ȫ������</h1>
<table class="menu-table">
    <tr>
        <th>��������</th>
        <th>�۸�</th>
        <th>����ʱ��</th>
        <th>���к�</th>
        <th>����״̬</th>
        <th>����</th>
    </tr>
    <% if (orders != null && !orders.isEmpty()) {
        for (OrderInfo order : orders) { %>
    <tr>
        <td><%= order.getDescription() %></td>
        <td><%= order.getPrice() %>Ԫ</td>
        <td><%= order.getOrderTime() %></td>
        <td><%= order.getSequenceNumber() %></td>
        <td><%= order.getOrderStatus() %></td>
        <td>
            <% if ("δ֧��".equals(order.getOrderStatus())) { %>
            <a href="pay.jsp?order=<%= order.getSequenceNumber() %>">֧��</a>
            <% } %>
        </td>
    </tr>
    <% }
    } else { %>
    <tr>
        <td colspan="6">��δ����</td>
    </tr>
    <% } %>
</table>
<form action="index.jsp" method="get">
    <input type="submit" value="������ҳ" class="return-button">
</form>
</body>
</html>