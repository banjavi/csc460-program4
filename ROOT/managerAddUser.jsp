<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="error.jsp"%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
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

    <h3>Add a New User Below</h3>

		<form action="managerAddUserServlet.jsp" method="POST">
		    <input type="text" name="username" placeholder="Username" required>
    		<br/>
    		<input type="password" name="password" placeholder="Password" required>
    		<br/>
        <input type="text" name="type" placeholder="Type" required>
          <br/>
    		<button type="submit">Submit</button>
		</form>

      <br/>
      <br/>
      <br/><br/><br/><br/><br/>
    <a href="managerMenu.jsp">Back</a>
    </center>
  </body>
</html>
