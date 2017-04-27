<!DOCTYPE html>

<html>
	<head>
		<title>Welcome to the CSc 460 Supermarket</title>
		<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
		<script type="text/javascript" src="scripts/search.js"></script>

		<style>
			body {
	        	background-image: url("back.jpg");
	        	background-size: cover;
	        	background-repeat: no-repeat;
	        	background-position: center center;
			}

			input[type=text], input[type=password] {
    			width: 20%;
    			padding: 12px 20px;
    			margin: 8px 0;
    			display: inline-block;
    			border: 1px solid #ccc;
    			box-sizing: border-box;
			}

			button {
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
  		<h1 style="color: white"><b>Welcome to the CSc460 Supermarket</b></h1>
  		</div>

		<div class="container" align="center">
    		<label style="color: white"><b>Username</b></label>
    		<input type="text" id="myText" placeholder="Please Enter Username" required>
    		<br/>

    		<label style="color: white"><b>Password </b></label>
    		<input type="password" placeholder="Please Enter Password" required>
    		<br/>
        
    		<button type="button" id="btn_search" onclick="window.location.href='welcome.jsp'">Login</button>
    		<button type="button" id="btn_return" onclick="window.location.href='index.html'">Back</button>
    		<br/><br/>
  		</div>

  		<div align="center" style="position: absolute; bottom: 5px;">
  			<hr/>
    		<p style="color: white"> &copy; Designed by Yawen Chen and Jacob Combs </p>
    	</div>

<!-- 
    	<script>
			function myFunction() {
    			var x = document.getElementById("myText").value;
    			window.location.href="./welcome.html";
			}
		</script>
 -->
	</body>
</html>

