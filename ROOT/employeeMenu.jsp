<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Employee Menu</title>
  </head>
  <body>
    <br/><br/><br/><br/><br/>
    <center>
      <h2>
        <%
        String currentUser = session.getAttribute("username").toString();
        String currentType = session.getAttribute("type").toString();
        out.println("Hello " + currentUser + " | " + currentType);
        %>
      </h2>

		<a href="employeeCheckOutCustomer.jsp">Perform Customer Check-out</a><br/><br/>

      <br/>
      <br/>
      <br/><br/><br/><br/><br/>
    <a href="logout.jsp">Logout</a>
    </center>
  </body>
</html>
