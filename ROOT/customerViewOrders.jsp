<!DOCTYPE html>
<%@page import="java.util.*, java.lang.*, java.lang.StringBuffer,
	dbController.DatabaseController" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Orders</title>
  </head>
  <body>
    <br/><br/><br/><br/><br/>
    <center>
      <h2>
        <%
        String currentUser = session.getAttribute("username").toString();
        String currentType = session.getAttribute("type").toString();
				String currentID = session.getAttribute("id").toString();

        out.println("Hello " + currentUser + " | " + currentType);
        %>
      </h2>
      <h3>Past Online Order Information</h3>


			<%
				DatabaseController dbcontroller = new DatabaseController();
				dbcontroller.Open();
				// writing the content on output/response page
			out.write("<hr/>");

		// stringbuffer to hold final content
		StringBuffer content = new StringBuffer();
		content.append("<table>");

		// asking dbcontroller to list the unprocessed orders table
		Vector<String> vecResult = dbcontroller.viewCustomerOrders(currentID);
		if (vecResult == null) {
					 content.append("Query result is null!");
				}
		int currentOrderID = -1;
		for (int i = 0; i < vecResult.size(); i++) {
			String[] record = vecResult.get(i).split("##");
			int oID = Integer.parseInt(record[0]);
			if (currentOrderID != oID) {
				currentOrderID = oID;
				double tempTotal = dbcontroller.TotalCost(oID);
				String totalCost = "$" + String.format("%.2f", tempTotal);
				//content.append("<th><u><strong>Total Cost: " + totalCost + "</th></u></strong>");
				if (record[2].equals("1899-12-31")) { // order hasn't been picked up yet
					content.append("<br/><tr><th><u><h3> Order#: " + record[0] + " placed on " + record[1] +
                                        ", Schedule Pickup | Total Cost: " + totalCost + " </h3></u></th></tr>");
				} else {
					content.append("<br/><tr><th><u><h3> Order#: " + record[0] + " placed on " + record[1] +
					", picked up on " + record[2] + " | Total Cost: " + totalCost +"</h3></u></th></tr>");
				}
				content.append("<tr><th><u>Name</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
					"<th><u>Quantity</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " +
					"<th><u>Cost</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");


			}
			double temp = Double.parseDouble(record[5]);
			record[5] = "$" + String.format("%.2f", temp);

			content.append("<tr><td>" + record[3] + "</td><td>" + record[4] + "</td><td>"  + record[5] + "</td></tr>");


		}

			out.write(content.toString());
			out.write("</table><hr/>");
				dbcontroller.Close();
			%>



      <br/>
      <br/>
      <br/><br/><br/><br/><br/>
    <a href="customerMenu.jsp">Back</a>
    </center>
  </body>
</html>
