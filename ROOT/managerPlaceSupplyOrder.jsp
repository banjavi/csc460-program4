<!DOCTYPE html>
<%@page import="java.util.*, java.lang.*, java.lang.StringBuffer,
	dbController.DatabaseController" %>
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
      <h3>Place an Order</h3>

      <%
        DatabaseController dbcontroller = new DatabaseController();
        dbcontroller.Open();
        // writing the content on output/response page
    		out.write("<hr/>");

    		// stringbuffer to hold final content
    		StringBuffer content = new StringBuffer();;
    		content.append("<table>");

    		// asking dbcontroller to list the products table
    		Vector<Vector<String>> vecResult = dbcontroller.FindAllProducts();
    		if (vecResult == null) {
               content.append("Query result is null!");
          }

		for (Vector<String> category: vecResult) {
			String[] firstRecord = category.get(0).split("##");
			String categoryName = firstRecord[firstRecord.length-1];
			content.append("<tr><th><u><h2>" + categoryName + "</h2></u></th></tr>");
			content.append("<tr><th><u>Barcode</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
  			"<th><u>Name</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " +
        "<th><u>Stock</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " +
  			"<th><u>Price</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");
			for (int i = 0; i < category.size(); i++) {
				String[] record = category.get(i).split("##");
        int barcodeValue = Integer.parseInt(record[0]);
        record[0] = "#" + String.format("%06d", barcodeValue);
				content.append("<tr id=\"tablerow_" + i + "\">");
				content.append("<td>" + record[0] + "</td>");
				content.append("<td>" + record[1] + "</td>");
        content.append("<td>" + record[2] + "</td>");
				content.append("<td>" + record[3] + "</td>");
				content.append("<td><input type=\"number\" value=\"0\" min=\"0\" max=\"" + record[2] + "\" name=\"" + record[0] +"\" ></td>"); // name is product id
				content.append("</tr>");
			}
		}

    		out.write(content.toString());
  		out.write("</table><hr/>");
      dbcontroller.Close();
        %>



		<form action="managerPlaceSupplyOrderServlet.jsp" method="POST">

    		<button type="submit">Place Order</button>
		</form>

      <br/>
      <br/>
      <br/><br/><br/><br/><br/>
    <a href="managerMenu.jsp">Back</a>
    </center>
  </body>
</html>
