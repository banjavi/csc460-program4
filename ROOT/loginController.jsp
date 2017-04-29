<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" %>
<html>
<head>
	<title> test login </title>
	<meta charset=UTF-8" />
	<script type="text/javascript"></script>
</head>
<body>
<p>userName: <%= request.getParameter("user")%> </p>
</br>
<p>pass: <%= request.getParameter("pass")%> </p>
<%
	request.setCharacterEncoding("utf-8");
 	response.setContentType("text/html;charset=utf-8");
	
	DatabaseController dbcontroller = new DatabaseController();
	dbcontroller.Open();
	
	dbcontroller.Close();
%>
</body>
</html> 
