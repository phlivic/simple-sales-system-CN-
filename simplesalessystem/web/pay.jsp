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
    <title>֧��</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script>
        function completePayment(paymentMethod) {
            <% if (currentOrder != null) { %>
            <% currentOrder.setOrderStatus("׼����"); %>
            // ����ServletContext�еĶ�����Ϣ����
            context.setAttribute("orders", orders);
            <% } %>
            alert(paymentMethod + " ֧���ɹ���");
            window.location.href = "index.jsp";
        }
    </script>
</head>
<body>
<h1>֧������</h1>
<% if (currentOrder != null) { %>
<p>�����ţ�<%= currentOrder.getSequenceNumber() %></p>
<p>����״̬��<%= currentOrder.getOrderStatus() %></p>
<div>
    <img src="wechat.jfif" alt="΢��֧��" class="img" onchange="completePayment('΢��')" h>
    <img src="alipay.jfif" alt="֧����" class="img" onchange="completePayment('֧����')" >
</div>
<% } else { %>
<p>���������ڻ���֧����</p>
<% } %>
<form action="index.jsp" method="get">
    <input type="submit" value="������ҳ" class="return-button">
</form>
</body>
</html>