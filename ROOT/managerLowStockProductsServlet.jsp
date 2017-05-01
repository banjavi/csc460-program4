<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
<head>
	<title> Low Stock JSP </title>
	<meta charset=UTF-8" />
	<script type="text/javascript"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
 	response.setContentType("text/html;charset=utf-8");
	String currentUser = session.getAttribute("username").toString();
    	String currentType = session.getAttribute("type").toString();
	
	String qty = request.getParameter("qty");
	session.setAttribute("lowQty", qty);
		if (currentType.equals("Manager"))
    			response.sendRedirect("managerLowStockProducts.jsp");
		else
			response.sendRedirect("employeeMenu.jsp");
%>
</body>
</html>
