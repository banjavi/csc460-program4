<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>
<html>
<head>
	<title> Place Order JSP </title>
	<meta charset=UTF-8" />
	<script type="text/javascript"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
 	response.setContentType("text/html;charset=utf-8");

	String username = request.getParameter("username");
	int currentID = Integer.parseInt(session.getAttribute("id").toString());
	DatabaseController dbcontroller = new DatabaseController();
	dbcontroller.Open();
	int orderID = -1;
	boolean orderSuccess = false;
	for (int i = 1; i <= 24; i++) {
		int qty = Integer.parseInt(request.getParameter(i+""));
		if (qty > 0) {
			orderID = dbcontroller.orderProducts(currentID, i, qty, orderID); 
			orderSuccess = true;
		}
	}
	
	if(orderSuccess == true){
    		response.sendRedirect("customerMenu.jsp");
	}
	else {
		response.sendRedirect("error.jsp");
	}
	dbcontroller.Close();
%>
</body>
</html>
