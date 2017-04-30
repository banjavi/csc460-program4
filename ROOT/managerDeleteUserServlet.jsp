<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
<head>
	<title> Add User JSP </title>
	<meta charset=UTF-8" />
	<script type="text/javascript"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
 	response.setContentType("text/html;charset=utf-8");

	String username = request.getParameter("username");


	DatabaseController dbcontroller = new DatabaseController();
	dbcontroller.Open();

	boolean deleteSuccess =  dbcontroller.deleteUser(username); // user type (Manager, Employee, Customer)

  if(deleteSuccess == true){
    response.sendRedirect("managerMenu.jsp");
	}
	else {
		response.sendRedirect("error.jsp");
	}
	dbcontroller.Close();
%>
</body>
</html>
