
<%@ page contentType="text/html;Charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="base.ShopClientBean"%>
<%@ page import="base.OrderInfo"%>
<%@ page import="java.util.List"%>
<jsp:useBean id="client" class="base.ShopClientBean" scope="request"/>
<html>
<head>
  <title>shop</title>
  <link rel="stylesheet" type="text/css" href="style.css">
  <script>
    function isDigit(s) {
      var patrn=/^[1-9]{1}$/;
      if (!patrn.exec(s)) {
        alert("������Χ������1��9��")
        var numInput = document.getElementById('num');
        numInput.value = 1;
        calculatePrice();
      };
    }
    function setDecoratorNum(value) {
      var numInput = document.getElementById('num');
      var newValue = parseInt(numInput.value) + value;
      if (newValue > 0 && newValue < 10) {
        numInput.value = newValue;
      }
    }
    function updateDecorator(decorator) {
      var numInput = document.getElementById('num');
      var buttons = document.getElementsByClassName('decorator-button');
      if (decorator.value === "") {
        numInput.value = 0;
        for (var i = 0; i < buttons.length; i++) {
          buttons[i].disabled = true;
        }
      } else {
        numInput.value = 1;
        for (var i = 0; i < buttons.length; i++) {
          buttons[i].disabled = false;
        }
      }
    }
    function updateImage(product) {
      var image = document.getElementsByClassName('coffee-image')[0];
      if (product.value === "tea") {
        image.src = 'tea.jfif';
        image.alt = 'Tea Image';
      } else if (product.value === "coca") {
        image.src = 'coca.jfif';
        image.alt = 'Coca Image';
      } else if (product.value === "coffee") {
        image.src = 'coffee.jfif';
        image.alt = 'Coffee Image';
      }
    }
    function confirmPurchase() {
      return confirm("�Ƿ���");
    }

    function confirmCancel() {
      return confirm("�Ƿ������");
    }
    var prices = {
      'tea': 1.5,
      'coca': 1,
      'coffee': 2,
      'ice': 0.5,
      'milk': 0.75,
      'sugar': 0.25,
      '': 0.0
    };
    function calculatePrice() {
      var productSelect = document.getElementsByName('product')[0];
      var decoratorSelect = document.getElementsByName('decorator')[0];
      var numInput = document.getElementById('num');
      var productPrice = prices[productSelect.value];
      var decoratorPrice = prices[decoratorSelect.value];
      var num = parseInt(numInput.value);
      var totalPrice = (productPrice + decoratorPrice * num).toFixed(2); // �����ܼ�

      var priceDisplay = document.getElementById('dynamicPrice');
      priceDisplay.innerText = '�۸�' + totalPrice + 'Ԫ';
    }
    // ҳ�������ɺ󣬼�����ʾ��ʼ�۸�
    window.onload = function() {
      calculatePrice();
    };
    function gotoPrice() {
      window.location.href = "menu.jsp";
    }
    function gotoOrder() {
      window.location.href = "order.jsp";
    }
  </script>
</head>
<body>
<div class="container">
  <img src="tea.jfif" alt="Coffee Image" class="coffee-image">
  <form action="shopService" method="post" class="order-form">
    <h1 style="text-align:center; font-weight:bold;">��ӭʹ�ñ���˾�����µ�ϵͳ</h1>
    <div class="form-group">
      ����Ҫ��������ǣ�
      <select name="product" onchange="updateImage(this); calculatePrice();">
        <option value="tea">��(tea)</option>
        <option value="coca">����(coca)</option>
        <option value="coffee">����(coffee)</option>
      </select>
    </div>
    <div class="form-group">
      ����Ҫ�����ϼӵ������ǣ�
      <select name="decorator" onchange="updateDecorator(this); calculatePrice();">
        <option value="ice">��(ice)</option>
        <option value="milk">ţ��(milk)</option>
        <option value="sugar">�������(sugar)</option>
        <option value="">��(None)</option>
      </select>
    </div>
    <div class="form-group decorator-group">
      ����/�ݣ�
      <button type="button" class="decorator-button" onclick="setDecoratorNum(-1); calculatePrice();">-</button>
      <input type="text" id="num" name="num" value="1" onchange="isDigit(this.value); calculatePrice();" class="num-input">
      <button type="button" class="decorator-button" onclick="setDecoratorNum(1); calculatePrice();">+</button>
    </div>
    <div class="form-group">
      <input type="submit" value="�ύ" onclick="return confirmPurchase()" class="submit-button">
      <input type="reset" value="����" onclick="return confirmCancel()" class="cancel-button">
      <input type="button" value="�˵�" onclick="gotoPrice()" class="submit-button">
      <input type="button" value="����" onclick="gotoOrder()" class="submit-button">
    </div>
    <div id="dynamicPrice" class="dynamicPrice">

    </div>

    <div class="order-summary">
      ���ϴ���������Ϻ������ǣ�<span id="description"><%= session.getAttribute("description") %></span><br/>
      ���ϴ�������������ϼ۸��ǣ�<span id="price"><%= session.getAttribute("price") %></span><br/>
      ��Ŀǰ�������Ѷ<span id="totalCost"><%= session.getAttribute("totalCost") %></span>
    </div>
    <div class="orders-container">
      <% List<OrderInfo> orders = (List<OrderInfo>) request.getServletContext().getAttribute("orders");
        if (orders != null) {
          for (OrderInfo order : orders) {
            if (order.getIsNew()){ %>
      <div class="order-info" id="order<%= order.getSequenceNumber() %>">
        ����������<span><%= order.getDescription() %></span><br/>
        �����۸�<span><%= order.getPrice() %></span><br/>
        ����ʱ�䣺<span><%= order.getOrderTime() %></span><br/>
        ���кţ�<span><%= order.getSequenceNumber() %></span><br/>
        ����״̬��<span class="orderStatus"><%= order.getOrderStatus() %></span><br/>
      </div>
      <%    }
          }
       }%>
    </div>
  </form>
</div>
</body>
</html>