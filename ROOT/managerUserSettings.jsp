<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Settings</title>
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
      <h3>Talbe of Existing Users</h3>

      <%
        DatabaseController dbcontroller = new DatabaseController();
        dbcontroller.Open();
        // writing the content on output/response page
    		out.write("<hr/>");

    		// stringbuffer to hold final content
    		StringBuffer content = new StringBuffer();;
    		content.append("<table>");

    		// asking dbcontroller to list the employee table
    		Vector<String> vecResult = dbcontroller.FindAllUsers();
    		if (vecResult == null) {
               content.append("Query result is null!");
          }

  		content.append("<tr><th><u>ID</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
  		"<th><u>Username</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " +
  		"<th><u>Type</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");

    		if (vecResult != null && vecResult.size() > 0) {
      		for (int i = 0; i < vecResult.size(); i++) {
        			String row = vecResult.get(i);
       		 	String[] detail = row.split("##");

       	 		content.append(
            			"<tr id=\"tablerow_" + i + "\">");
        			content.append(
            			"<td class=\"postlist\">" +
            			detail[0] + "</td>");
        			content.append(
            			"<td>" + detail[1] + "</td>");
        			content.append("<td>" + detail[2] + "</td>");
        			content.append("</tr>");
      		}
    		}
    		out.write(content.toString());
  		out.write("</table><hr/>");
      dbcontroller.Close();
        %>



		<form action="managerAddUserServlet.jsp" method="POST">
        <h4>Add User </h4>
		    <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="text" name="type" placeholder="Type" required>
    		<button type="submit">Submit</button>
		</form>


		<form action="managerDeleteUserServlet.jsp" method="POST">
        <h4>Delete User </h4>
		    <input type="text" name="username" placeholder="Username" required>
    		<button type="submit">Submit</button>
		</form>


		<form action="managerUpdateUserServlet.jsp" method="POST">
        <h4>Update User Type </h4>
        <input type="text" name="username" placeholder="Username" required>
		    <input type="text" name="type" placeholder="New Type" required>
    		<button type="submit">Submit</button>
		</form>

      <br/>
      <br/>
      <br/><br/><br/><br/><br/>
    <a href="managerMenu.jsp">Back</a>
    </center>
  </body>
</html>
