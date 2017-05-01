<!DOCTYPE html>
<%@page import="java.util.*, java.lang.*, java.lang.StringBuffer,
	dbController.DatabaseController" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View All Customer Orders</title>
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
      <h3>All Customer Order Information</h3>


			<%
				DatabaseController dbcontroller = new DatabaseController();
				dbcontroller.Open();
				// writing the content on output/response page
			out.write("<hr/>");

		// stringbuffer to hold final content
		StringBuffer content = new StringBuffer();
		content.append("<table>");

		// asking dbcontroller to list the unprocessed orders table
		Vector<String> vecResult = dbcontroller.viewAllOrders("Customer");
    if (vecResult == null) {
           content.append("Query result is null!");
      }

  content.append("<tr><th><u>OrderID</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
  "<th><u>UserID</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " +
  "<th><u>Date Placed</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " +
  "<th><u>Pickup Date</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " +
  "<th><u>Product Barcode</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " +
  "<th><u>Quantity</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");

    if (vecResult != null && vecResult.size() > 0) {
      for (int i = 0; i < vecResult.size(); i++) {
          String row = vecResult.get(i);
        String[] detail = row.split("##");
        int barcodeValue = Integer.parseInt(detail[4]);
        detail[4] = "#" + String.format("%06d", barcodeValue);
        if (detail[3].equals("1899-12-31"))
          detail[3] = "SCHEDULE PICKUP";
        content.append("<tr id=\"tablerow_" + i + "\">");
          content.append("<td>" + detail[0] + "</td>");
          content.append("<td>" + detail[1] + "</td>");
          content.append("<td>" + detail[2] + "</td>");
          content.append("<td>" + detail[3] + "</td>");
          content.append("<td>" + detail[4] + "</td>");
          content.append("<td>" + detail[5] + "</td>");
          content.append("</tr>");
      }
    }
    out.write(content.toString());
  out.write("</table><hr/>");
  dbcontroller.Close();
    %>



      <br/>
      <br/>
      <br/><br/><br/><br/><br/>
    <a href="employeeMenu.jsp">Back</a>
    </center>
  </body>
</html>
