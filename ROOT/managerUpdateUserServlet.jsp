<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
<head>
	<title> Update User JSP </title>
	<meta charset=UTF-8" />
	<script type="text/javascript"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
 	response.setContentType("text/html;charset=utf-8");

	String username = request.getParameter("username");
  String type = request.getParameter("type");

	DatabaseController dbcontroller = new DatabaseController();
	dbcontroller.Open();

	boolean updateSuccess =  dbcontroller.updateUser(username, type); // user type (Manager, Employee, Customer)

  if(updateSuccess == true){
    response.sendRedirect("managerUserSettings.jsp");
	}
	else {
		response.sendRedirect("error.jsp");
	}
	dbcontroller.Close();
%>
</body>
</html>
