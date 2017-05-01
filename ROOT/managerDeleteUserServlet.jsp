<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" %>
<html>
<head>
	<title> Delete User JSP </title>
	<meta charset=UTF-8" />
	<script type="text/javascript"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
 	response.setContentType("text/html;charset=utf-8");

	String id = request.getParameter("id");


	DatabaseController dbcontroller = new DatabaseController();
	dbcontroller.Open();

	boolean deleteSuccess =  dbcontroller.deleteUser(id); // user type (Manager, Employee, Customer)

  if(deleteSuccess == true){
    response.sendRedirect("managerUserSettings.jsp");
	}
	else {
		response.sendRedirect("error.jsp");
	}
	dbcontroller.Close();
%>
</body>
</html>
