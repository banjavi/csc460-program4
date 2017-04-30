<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" %>
<html>
<head>
	<title> Login JSP </title>
	<meta charset=UTF-8" />
	<script type="text/javascript"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
 	response.setContentType("text/html;charset=utf-8");

	String username = request.getParameter("username");
	String password = request.getParameter("password");

	DatabaseController dbcontroller = new DatabaseController();
	dbcontroller.Open();

	String loginResult =  dbcontroller.authenticate(username, password); // user type (Manager, Employee, Customer)

	if(loginResult.compareTo("error") != 0){
		String[] resultArray = loginResult.split(",");
		String resultUser= resultArray[0];
		String resultType= resultArray[1];
		session.setAttribute("username", resultUser);
		session.setAttribute("type", resultType);
		if(resultType.compareTo("Manager") == 0)
			response.sendRedirect("managerMenu.jsp");
		if(resultType.compareTo("Employee") == 0)
			response.sendRedirect("employeeMenu.jsp");
		if(resultType.compareTo("Customer") == 0)
			response.sendRedirect("customerMenu.jsp");
	}

	else {
		response.sendRedirect("error.jsp");

	}
	dbcontroller.Close();
%>
</body>
</html>
