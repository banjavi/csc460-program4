package dbController;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.InputMismatchException;
import java.util.Scanner;
import java.util.Vector;

public class DatabaseController {
	static final long serialVersionUID = 1L;
	  /**
	   * A handle to the connection to the DBMS.
	   */
	  protected Connection connection_;
	  /**
	   * A handle to the statement.
	   */
	  protected Statement statement_;
	  /**
	   * The connect string to specify the location of DBMS
	   */
	  protected String connect_string_ = null;
	  /**
	   * The password that is used to connect to the DBMS.
	   */
	  protected String password = null;
	  /**
	   * The username that is used to connect to the DBMS.
	   */
	  protected String username = null;

	public DatabaseController() {
	    // your cs login name
	    username = "banjavi"; // need owner of table for insertions
	    // your Oracle password, NNNN is the last four digits of your CSID
	    password = "a1095"; // need owner of table for insertions
	    connect_string_ = "jdbc:oracle:thin:@aloe.cs.arizona.edu:1521:oracle";
	  }


	/**
	   * Closes the DBMS connection that was opened by the open call.
	   */
	  public void Close() {
	    try {
	      statement_.close();
	      connection_.close();
	    } catch (SQLException e) {
	      e.printStackTrace();
	    }
	    connection_ = null;
	  }


	  /**
	   * Commits all update operations made to the dbms.
	   * If auto-commit is on, which is by default, it is not necessary to call
	   * this method.
	   */
	  public void Commit() {
	    try {
	      if (connection_ != null && !connection_.isClosed())
	        connection_.commit();
	    } catch (SQLException e) {
	      System.err.println("Commit failed");
	      e.printStackTrace();
	    }
	  }

	  public void Open() {
	    try {
	        Class.forName("oracle.jdbc.OracleDriver");
	        connection_ = DriverManager.getConnection(connect_string_, username, password);
	        statement_ = connection_.createStatement();
	        return;
	    } catch (SQLException sqlex) {
	        sqlex.printStackTrace();
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	        System.exit(1); //programemer/dbsm error
	    } catch (Exception ex) {
	        ex.printStackTrace();
	        System.exit(2);
	    }
	    }

	
		//groups by category
	  public Vector<Vector<String>> FindAllProducts() {
	    String sql_query = "SELECT * FROM banjavi.products order by category, name";
	    try {
			ResultSet rs  = statement_.executeQuery(sql_query);
			Vector<Vector<String>> result_category = new Vector<Vector<String>>();
			String currentCategory = "";
			int categoryIndex = -1;
			while (rs.next()) {
				String category = rs.getString("CATEGORY");
				if (!currentCategory.equals(category)) { // create new list for that category
					categoryIndex++;
					currentCategory = category;
					result_category.add(categoryIndex, new Vector<String>());
			 	}
	     	String temp_record = rs.getInt("PRODUCT_ID") + "##" + rs.getString("NAME") +
         	"##" + rs.getInt("STOCK") + "##" +rs.getDouble("PRICE") + "##" + category;
			//System.out.println(temp_record);
	        result_category.get(categoryIndex).add(temp_record);
	      	}
	      	return result_category;
	    } catch (SQLException sqlex) {
	      sqlex.printStackTrace();
	    }
	    return null;
	  }

		// there should either be 1 or 0 tuples returned - we need to prevent duplicate users later on
		public String authenticate (String username, String password) {
			String sql_query = "SELECT username, type FROM banjavi.users WHERE username= '" + username + "' AND password= '" + password + "'";
			try {
				ResultSet rs  = statement_.executeQuery(sql_query);
				String result="";
				if (rs.next())
					 result = rs.getString("username") + "," + rs.getString("type");
				else
					result = "error";

				return result;
			} catch (SQLException sqlex) {
				sqlex.printStackTrace();
			}
			return "error";
		}
	
	public Vector<String> viewPastOrders(int userID) {
			String sql_query = "SELECT * FROM banjavi.orders WHERE user_id= '" + userID + "'";
			try {
				ResultSet rs = statement_.executeQuery(sql_query);
				Vector<String> result_orders = new Vector<String>();
				while(rs.next()) {
					String temp_record = rs.getInt("PURCHASE_ID") + "##" + rs.getInt("ORDER_ID") +
							"##" + rs.getInt("USER_ID") + "##" + rs.getDate("DATE_PLACED") + "##" +
							rs.getDate("PICK_UP_DATE") + "##" + rs.getInt("PRODUCT_ID") + "##" +
							rs.getInt("QUANTITY");
					result_orders.add(temp_record);
				}
				return result_orders
			} catch (SQLException sqlex) {
				sqlex.printStackTrace();
			}
		return null;
	}
	
	public Vector<String> viewAllPastOrders() {
		String sql_query = "SELECT * FROM banjavi.orders ORDER BY order_id";
		try {
			ResultSet rs = statement_.executeQuery(sql_query);
			Vector<String> result_orders = new Vector<String>();
			while(rs.next()) {
				String temp_record = rs.getInt("PURCHASE_ID") + "##" + rs.getInt("ORDER_ID") +
						"##" + rs.getInt("USER_ID") + "##" + rs.getDate("DATE_PLACED") + "##" +
						rs.getDate("PICK_UP_DATE") + "##" + rs.getInt("PRODUCT_ID") + "##" +							rs.getInt("QUANTITY");
					result_orders.add(temp_record);
			}
			return result_orders
			} catch (SQLException sqlex) {
				sqlex.printStackTrace();
			}
		return null;
	}
	
	public Vector<String> viewUnprocessedOrders() {
		String sql_query = "SELECT * FROM banjavi.orders WHERE pick_up_date= NULL";
		try{
			ResultSet rs = statement_.executeQuery(sql_query);
			Vector<String> result_orders = new Vector<String>();
			while(rs.next()) {
				String temp_record = rs.getInt("PURCHASE_ID") + "##" + rs.getInt("ORDER_ID") +
						"##" + rs.getInt("USER_ID") + "##" + rs.getDate("DATE_PLACED") + "##" +
						rs.getDate("PICK_UP_DATE") + "##" + rs.getInt("PRODUCT_ID") + "##" +
						rs.getInt("QUANTITY");
				result_order.add(temp_record);
			}
			return result_orders
			} catch (SQLException sqlex) {
				sqlex.printStackTrace();
			}
		return null;
	}	

	public boolean insertUser (String username, String password, String type) {


			String sql_query = 	"insert into banjavi.users values(0,'" + username +"','" + password + "','" + type + "')";
			try {
				ResultSet rs  = statement_.executeQuery(sql_query);
				return true; // should only execute if the user could be inserted
			} catch (SQLException sqlex) {
				sqlex.printStackTrace();
			}
			return false;
		}
	
	public void checkout(int orderID) {
			Date pick_up = new Date();
			pick_up.setHours(0);
			String sql_query = "UPDATE banjavi.orders SET pick_up_date= '" + pick_up "' WHERE order_id= '" + orderID + "'";
			statement_.execute(sql_query);
		}

		public Vector<String> FindAllUsers() {
			String sql_query = "SELECT user_id, username,type FROM banjavi.users order by username";
			try {
				ResultSet rs  = statement_.executeQuery(sql_query);
				Vector<String> result_users = new Vector<String>();
				while (rs.next()) {
					 String temp_record = rs.getInt("USER_ID") + "##" + rs.getString("USERNAME") +
							 "##" + rs.getString("TYPE");
					//System.out.println(temp_record);
					result_users.add(temp_record);
				}
				return result_users;
			} catch (SQLException sqlex) {
				sqlex.printStackTrace();
			}
			return null;
		}


		public boolean deleteUser (String username) {

			String sql_query = 	"delete banjavi.users where username=" + "'" + username +"'";
			try {
				ResultSet rs  = statement_.executeQuery(sql_query);
				return true; // should only execute if the user could be inserted
			} catch (SQLException sqlex) {
				sqlex.printStackTrace();
			}
			return false;
		}

	public Vector<String> GetPastSupplyOrdersManager(String query1,String input1, String query2,String input2){
		//allows for two query options limited to show a certain date, user, or order;
			Boolean q1 = false;
			Boolean q2 = false;
			String sql_query = "select * from orders";
		
			if(!query1.equals("N/A") ){
				q1 = true;
				if(query1.equals("DatePlaced")){
					sql_query = sql_query + " where DatePlaced = " + input1;
				}
				else if(query1.equals("OrderID")){
					sql_query = sql_query + " where OrderID = " + input1;
				}
				else if(query1.equals("UserID")){
					sql_query = sql_query + " where UserID = " + input1;
				}
			}
			if(!query2.equals("N/A") ){
				q2 = true;
				
				if(q1 == true){
					sql_query = sql_query + " and ";
				}
				
				if(query2.equals("DatePlaced")){
					sql_query = sql_query + " where DatePlaced = " + input2;
				}
				else if(query2.equals("OrderID")){
					sql_query = sql_query + " where OrderID = " + input2;
				}
				else if(query2.equals("UserID")){
					sql_query = sql_query + " where UserID = " + input2;
				}
			}
			
			try {
				ResultSet rs  = statement_.executeQuery(sql_query);
				Vector<String> result_users = new Vector<String>();
				while (rs.next()) {
					 String temp_record = rs.getInt("ORDERID") + "##" + rs.getString("USERID") +
							 "##" + rs.getString("DATEPLACED")+ "##" + rs.getString("PICKUPDATE")+"##" +  rs.getString("PRRODUCTID")
					 + "##" + rs.getString("QUANTITY");
					
					result_users.add(temp_record);
				}
				return result_users;
			} catch (SQLException sqlex) {
				sqlex.printStackTrace();
			}
			return null;
		}

		//1) customer order products
		//2) customer view past orders


//		Scanner reader = new Scanner(System.in);
//		int userSelection = 0;
//		try {
//			userSelection = reader.nextInt();
//		} catch (InputMismatchException exception) {
//			System.out.println("Invalid selection option");
//			System.exit(-1);
//		}
//
//		// Connection to Send the query to the DBMS
//	//	Statement stmt = databaseConnect.createStatement();
//
//		if (userSelection == 1) {
//			//Customer adds a new order
//			ResultSet productsToAdd = null; //all products to add
//
//			int randomNum = 1234;
//			int orderId = 3454326;
//			int userId = 67876;
//			Date date = productsToAdd.getDate(0);
//			int productID = 34526;
//			int qty = 3;
//
//			//while(there exists a next product){
//			stmt.executeQuery("insert into orders values (" + randomNum + ", " + orderId +", " + userId +", "+ date +", "
//					+ null +", "+ productID + ", " + qty + ")");
//




}
