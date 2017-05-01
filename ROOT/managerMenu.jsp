<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Menu</title>
  </head>
  <body>
    <br/><br/><br/><br/><br/>
    <center>
      <h2>
        <%
        String currentUser = session.getAttribute("username").toString();
        String currentType = session.getAttribute("type").toString();
	session.setAttribute("ProductID", null);
        out.println("Hello " + currentUser + " | " + currentType);
        %>
      </h2>

      <a href="managerCheckOutCustomer.jsp">Perform Customer Check-out</a><br/><br/>
			<a href="managerPlaceSupplyOrder.jsp">Place New Supply Order</a><br/><br/>
			<a href="managerViewSupplyOrders.jsp">View Supply Orders</a><br/><br/>
      <a href="managerViewCustomerOrders.jsp">View Online Customer Orders</a><br/><br/>
      <a href="managerGetStockInfo.jsp">Get Information About McCannMart Current Stock</a><br/><br/>
			<a href="managerUserSettings.jsp">User Settings</a><br/><br/>
			<a href="managerLowStockProducts.jsp">View Products with Low Stock</a><br/><br/>
			 <a href="managerOrdersContainingProduct.jsp">Find Orders Containing a Product</a><br/><br/>

      <br/>
      <br/>
      <br/><br/><br/><br/><br/>
    <a href="logout.jsp">Logout</a>
    </center>
  </body>
</html>
