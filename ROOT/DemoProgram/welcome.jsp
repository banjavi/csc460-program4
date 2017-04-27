<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.util.*,java.lang.StringBuffer,
    dbController.DatabaseController" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Search Results</title>
		
		<style>
			button {
			    background-color: #4CAF50;
			    color: white;
			    padding: 14px 20px;
			    margin: 8px 0;
			    border: none;
			    cursor: pointer;
			    width: 100px;
			}
			
			table {
				font-size: 18px;
				font-family:'Verdana';
			}
		</style>
	</head>
	
	<body>
	
	<div id="searchresult" align="center" >
	<%
  		request.setCharacterEncoding("utf-8");
 	 	response.setContentType("text/html;charset=utf-8");

  		DatabaseController dbcontroller = new DatabaseController();
  		// connect to backend database server via the databasecontroller, which
  		// is a wrapper class providing necessary methods for this particular
  		// application
  		dbcontroller.Open();

  		// writing the content on output/response page
  		out.write("<h1 style=\"color: #4CAF50;\">All Products</h1>");
  		out.write("<hr/>");

  		// stringbuffer to hold final content
  		StringBuffer content = new StringBuffer();;
  		content.append("<table>");
		
  		// asking dbcontroller to list the employee table
  		Vector<String> vecResult = dbcontroller.FindAllProducts();   
  		if (vecResult == null) {
             content.append("Query result is null!");
        } 		

		content.append("<tr><th><u>Barcode</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" + 
		"<th><u>Name of Product</u>&nbsp;&nbsp;&nbsp;&nbsp;</th> " + 
		"<th><u>Price</u>&nbsp;&nbsp;&nbsp;&nbsp;</th>" +
   		"<th><u>Quantity</u>&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>");
  
  		if (vecResult != null && vecResult.size() > 0) {
    		for (int i = 0; i < vecResult.size(); i++) {
      			String row = vecResult.get(i);
     		 	String[] detail = row.split("##");
      			if (detail.length != 4) {
        		//break;
      			}
     	 	
     	 		content.append(
          			"<tr id=\"tablerow_" + i + "\">");
      			content.append(
          			"<td class=\"postlist\">" +
          			detail[0] + "</td>");
      			content.append(
          			"<td>" + detail[1] + "</td>");
      			content.append("<td>" + detail[2] + "</td>" +
                     "<td> &nbsp;&nbsp;" + detail[3] + "</td>");
      			content.append("</tr>");
    		}
  		}
  		out.write(content.toString());
		out.write("</table><hr/>");
  		// close the dbcontroller and relase all resources occupied by it.
  		dbcontroller.Close();
	%>
	</div>
	
	<br/>
    <center><button onClick="parent.location='SampleIndex.jsp'">Logout</button></center>
    
    <div align="center" style="position: absolute; bottom: 5px;">
  		<hr/>
    	<p style="color: Black"> &copy; Designed by Yawen Chen and Jacob Combs </p>
    </div>
	</body>
</html>
