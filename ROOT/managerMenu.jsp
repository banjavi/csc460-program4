<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
  <body>
    <br/><br/><br/><br/><br/>
    <center>
      <h2>
        <%
        String currentUser = session.getAttribute("username").toString();
        String currentType = session.getAttribute("type").toString();
        out.println("Hello " + currentUser + " | " + currentType);
        %>
      </h2>

      <a href="managerCheckOutCustomer.jsp">Perform Customer Check-out</a><br/><br/>
      <a href="managerGetOnlineOrderInfo.jsp">Get Information About Past Online Orders</a><br/><br/>
      <a href="managerGetStockInfo.jsp">Get Information About the Stores Current Stock</a><br/><br/>
      <a href="managerQueryPastSupplyOrders.jsp">Query Past Supply Orders</a><br/><br/>
      <a href="managerPlaceSupplyOrder.jsp">Place New Supply Orders</a><br/><br/>
      <a href="managerUpdateStockInfo.jsp">Update Stock Information</a><br/><br/> <!-- Add/Delete Products, Update Quantity, etc. -->
      <a href="managerAddUser.jsp">Add User</a><br/><br/>
      <a href="managerDeleteUser.jsp">Delete User</a><br/><br/>


      <br/>
      <br/>
      <br/><br/><br/><br/><br/>
    <a href="logout.jsp">Logout</a>
    </center>
  </body>
</html>
