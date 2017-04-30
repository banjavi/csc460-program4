<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Logout JSP</title>
    </head>
    <body>
      <%
      session.removeAttribute("username");
      session.removeAttribute("type");
      session.invalidate();
      response.sendRedirect("login.jsp"); // send user back to the login page
      %>
      <!-- <h1>Successful logout.</h1> -->
    </body>
</html>
