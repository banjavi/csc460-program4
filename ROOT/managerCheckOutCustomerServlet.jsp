<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
<head>
	<title> Checkout Order JSP </title>
	<meta charset=UTF-8" />
	<script type="text/javascript"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
 	response.setContentType("text/html;charset=utf-8");
	String currentUser = session.getAttribute("username").toString();
    	String currentType = session.getAttribute("type").toString();
	
	int orderID = Integer.parseInt(request.getParameter("orderid"));

	DatabaseController dbcontroller = new DatabaseController();
	dbcontroller.Open();

	boolean orderSuccess =  false;
	dbcontroller.checkout(orderID);
	orderSuccess = true; 

  if(orderSuccess == true){
		if (currentType.equals("Manager"))
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
