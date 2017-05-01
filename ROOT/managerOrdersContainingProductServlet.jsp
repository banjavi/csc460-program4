<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
<head>
	<title> Orders containing product JSP </title>
	<meta charset=UTF-8" />
	<script type="text/javascript"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
 	response.setContentType("text/html;charset=utf-8");
	String currentUser = session.getAttribute("username").toString();
    	String currentType = session.getAttribute("type").toString();
	
	String pid = request.getParameter("ProductID");
	session.setAttribute("ProductID", pid);
		if (currentType.equals("Manager"))
    			response.sendRedirect("managerOrdersContainingProduct.jsp");
		else
			response.sendRedirect("employeeOrdersContainingProduct.jsp");
%>
</body>
</html>
