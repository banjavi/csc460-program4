<!DOCTYPE html>
<%@page import="java.util.*, java.lang.StringBuffer,
	dbController.DatabaseController" errorPage="error.jsp" %>

<html>
	<head>
		<title>McCannMart | Login</title>
		<meta charset=UTF-8" />
		<script type="text/javascript"></script>

		<style>
			body {
	        	background-image: url("lolmccann.png");
	        	background-size: cover;
	        	background-repeat: no-repeat;

			}

			input[type=text], input[type=password] {
    			width: 20%;
    			padding: 12px 20px;
    			margin: 8px 0;
    			display: inline-block;
    			border: 3px solid #ccc;
    			box-sizing: border-box;
			}

			button{
			    background-color: #4CAF50;
			    color: white;
			    padding: 14px 20px;
			    margin: 8px 0;
			    border: none;
			    cursor: pointer;
			    width: 100px;
			}
		</style>
	</head>

	<body>
		<br/><br/><br/>
		<br/><br/><br/>
		<br/><br/><br/>
		<br/><br/><br/>

		<div align="center">
  		<h1 style="color: white"><b>Welcome to McCannMart!</b></h1>
  		</div>

		<div class="container" align="center">
		<form action="loginServlet.jsp" method="POST">
		<input type="text" name="username" placeholder="Username" required>
    		<br/>
    		<input type="password" name="password" placeholder="Password" required>
    		<br/>
    		<button type="submit" id="btn_search">Login</button>
    		<!-- <button type="button" id="btn_return" onclick="window.location.href='index.html'">Back</button> -->
		</form>
		<br/><br/>
  		</div>

  		<div align="center" style="position: absolute; bottom: 1px">
  			<hr/>
    		<p style="color: orange"><b> &copy; Designed by Alex Yee, Bijan Anjavi, Colin Widner, and Monica Sproul </b></p>
    	</div>

	</body>
</html>
