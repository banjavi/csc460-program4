<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" %>
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
	String password = request.getParameter("password");
  String type = request.getParameter("type");

	DatabaseController dbcontroller = new DatabaseController();
	dbcontroller.Open();

	boolean insertSuccess =  dbcontroller.insertUser(username, password, type); // user type (Manager, Employee, Customer)

  if(insertSuccess == true){
    response.sendRedirect("managerMenu.jsp");
	}
	else {
		response.sendRedirect("error.jsp");
	}
	dbcontroller.Close();
%>
</body>
</html>
