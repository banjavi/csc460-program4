<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
<head>
	<title> Place Order JSP </title>
	<meta charset=UTF-8" />
	<script type="text/javascript"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
 	response.setContentType("text/html;charset=utf-8");

	String username = request.getParameter("username");
	String order = request.getParameter("order");

	DatabaseController dbcontroller = new DatabaseController();
	dbcontroller.Open();

	boolean orderSuccess =  dbcontroller.orderProducts(username, order); 

  if(orderSuccess == true){
    response.sendRedirect("customerMenu.jsp");
	}
	else {
		response.sendRedirect("error.jsp");
	}
	dbcontroller.Close();
%>
</body>
</html>
