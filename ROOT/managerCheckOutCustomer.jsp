<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Place Order</title>
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
      <h3>Checkout Customer Order</h3>
		<form action="managerCheckOutCustomerServlet.jsp" method="POST">
		<p> OrderID to checkout:</p>
    		<input type="number" min="0" name="orderid" >
		<button type="submit">Checkout</button>
		</form>
      <%
        DatabaseController dbcontroller = new DatabaseController();
        dbcontroller.Open();
        // writing the content on output/response page
    	out.write("<hr/>");

		// stringbuffer to hold final content
		StringBuffer content = new StringBuffer();
		content.append("<table>");

		// asking dbcontroller to list the unprocessed orders table
		Vector<String> vecResult = dbcontroller.viewUnprocessedOrders();
		if (vecResult == null) {
           content.append("Query result is null!");
      	}
		int currentOrderID = -1;
		for (int i = 0; i < vecResult.size(); i++) {
			String[] record = vecResult.get(i).split("##");
			int oID = Integer.parseInt(record[1]);
			if (currentOrderID != oID) {
				currentOrderID = oID;
				content.append("<br/><tr><th><u><h3> Order #" + currentOrderID + " for User #" + record[2] +
				" placed on " + record[3] + "</h3></u></th></tr>");
			}
			content.append("<tr><td>" + record[5] + "</td><td>Qty " + record[6] + "</td></tr>");
		}
		
    	out.write(content.toString());
  		out.write("</table><hr/>");
      	dbcontroller.Close();
        %>
		

      <br/>
      <br/>
      <br/><br/><br/><br/><br/>
    <a href="managerMenu.jsp">Back</a>
    </center>
  </body>
</html>
