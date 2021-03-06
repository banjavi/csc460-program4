<!DOCTYPE html>
<%@page import="java.util.*, java.lang.*, java.lang.StringBuffer,
	dbController.DatabaseController" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Find Orders Containing Product</title>
  </head>
  <body>
    <br/><br/><br/><br/><br/>
    <center>
      <h2>
        <%
        String currentUser = session.getAttribute("username").toString();
        String currentType = session.getAttribute("type").toString();
	Object pid = session.getAttribute("ProductID");

        out.println("Hello " + currentUser + " | " + currentType);
        %>
      </h2>
		<form action="managerOrdersContainingProductServlet.jsp" method="POST">
                <p>Find orders with Barcode...</p>
                <input type="number" min="1" name="ProductID" >
                <button type="submit">Go</button>
                </form>
	
			<h3><%
			int productid=-1;
			if (pid == null) 
				out.println("Stock Information | " + "List of Products"); 
			else {
				productid = Integer.parseInt(pid.toString());
				out.println("Stock Information | " + "Orders containing barcode #" + String.format("%06d", productid));
				
			} %>
			</h3>
      <%
        DatabaseController dbcontroller = new DatabaseController();
        dbcontroller.Open();
        // writing the content on output/response page
    		out.write("<hr/>");

    		// stringbuffer to hold final content
    		StringBuffer content = new StringBuffer();
    		content.append("<table>");
		if (pid == null) {
    		// asking dbcontroller to list the products table
    		Vector<Vector<String>> vecResult = dbcontroller.FindAllProducts("All");
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
				double temp = Double.parseDouble(record[3]);
				record[3] = "$" + String.format("%.2f", temp);
				content.append("<td>" + record[3] + "</td>");
				content.append("</tr>");
			}
		}
		} else {
			Vector<Integer> vecResult = dbcontroller.OrdersContainingProduct(productid);
			 if (vecResult == null) {
                 		content.append("Query result is null!");
                  	 }
			 content.append("<tr><th><u><h2>Order ID</h2></u></th></tr>");
			 for (Integer oid: vecResult) {
				content.append("<tr><td>" + oid + "</td></tr>");
			 } 	
		}
    		out.write(content.toString());
  		out.write("</table><hr/>");
      dbcontroller.Close();
        %>
    <a href="employeeMenu.jsp">Back</a>
    </center>
  </body>
</html>
