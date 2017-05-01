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
	String currentUser = session.getAttribute("username").toString();
    String currentType = session.getAttribute("type").toString();
	
	String orderID = request.getParameter("orderid");

	DatabaseController dbcontroller = new DatabaseController();
	dbcontroller.Open();

	boolean orderSuccess =  dbcontroller.checkout(orderID); 

  if(orderSuccess == true){
		if (currentType.equals("Manager")
    		response.sendRedirect("managerMenu.jsp");
		else
			response.sendRedirect("employeeMenu.jsp");
	}
	else {
		response.sendRedirect("error.jsp");
	}
	dbcontroller.Close();
%>
</body>
</html>
