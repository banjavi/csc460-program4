import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.InputMismatchException;
import java.util.Scanner;

public class Proj4 {
	public static void main(String[] args) throws SQLException {
		/*
		 * The main class connects to the database and allows for my program to
		 * run queries on it. It also retrieves user input and directs the code
		 * to which query to run.
		 */

		// load the (Oracle) JDBC driver by initializing its base
		// class, 'oracle.jdbc.OracleDriver'
		try {

			Class.forName("oracle.jdbc.OracleDriver");

		} catch (ClassNotFoundException e) {

			System.err.println("*** ClassNotFoundException:  " + "Error loading Oracle JDBC driver.  \n"
					+ "\tPerhaps the driver is not on the Classpath?");
			System.exit(-1);

		}

		// Main Connection to database
		Connection databaseConnect = DriverManager.getConnection("jdbc:oracle:thin:@aloe.cs.arizona.edu:1521:oracle",
				"msproul", "a1894");
		
		//1) customer order products
		//2) customer view past orders
		
		
		Scanner reader = new Scanner(System.in);
		int userSelection = 0;
		try {
			userSelection = reader.nextInt();
		} catch (InputMismatchException exception) {
			System.out.println("Invalid selection option");
			System.exit(-1);
		}

		// Connection to Send the query to the DBMS
		Statement stmt = databaseConnect.createStatement();

		if (userSelection == 1) {
			//Customer adds a new order
			ResultSet productsToAdd = null; //all products to add
			
			int randomNum = 1234;
			int orderId = 3454326;
			int userId = 67876;
			Date date = productsToAdd.getDate(0);
			int productID = 34526;
			int qty = 3;
			
			//while(there exists a next product){
			stmt.executeQuery("insert into orders values (" + randomNum + ", " + orderId +", " + userId +", "+ date +", "
					+ null +", "+ productID + ", " + qty + ")");
		
			
		}
	}	
		
}
