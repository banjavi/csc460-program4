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
import java.util.Calendar;

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

		// there should either be 1 or 0 tuples returned - we need to prevent duplicate users later on
		public String authenticate (String username, String password) {
			String sql_query = "SELECT user_id, username, type FROM banjavi.users WHERE username= '" + username + "' AND password= '" + password + "'";
			try {
				ResultSet rs  = statement_.executeQuery(sql_query);
				String result="";
				if (rs.next())
					 result = rs.getInt("user_id") + "," + rs.getString("username") + "," + rs.getString("type");
				else
					result = "error";

				return result;
			} catch (SQLException sqlex) {
				sqlex.printStackTrace();
			}
			return "error";
		}

		public Vector<String> FindAllUsers() {
			String sql_query = "SELECT user_id, username,type FROM banjavi.users order by user_id";
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

    public boolean updateUser (String username, String newType) {

			String sql_query = 	"update banjavi.users set type='"+ newType + "'where username='" + username +"'";
			try {
				ResultSet rs  = statement_.executeQuery(sql_query);
				return true; // should only execute if the user could be inserted
			} catch (SQLException sqlex) {
				sqlex.printStackTrace();
			}
			return false;
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


		public Vector<String> viewCustomerOrders(String user_id) {
			String sql_query = "SELECT order_id, date_placed, pick_up_date, name, quantity, price * CAST(quantity AS number(*,2)) AS \"COST\" FROM banjavi.orders, banjavi.products WHERE banjavi.orders.product_id = banjavi.products.product_id AND user_id = " + user_id + " ORDER BY order_id";
			try {
			ResultSet rs  = statement_.executeQuery(sql_query);
			Vector<String> result_orders = new Vector<String>();
			while (rs.next()) {
	     	String temp_record = rs.getInt("ORDER_ID") + "##" + rs.getDate("DATE_PLACED") +
         	"##" + rs.getDate("PICK_UP_DATE") + "##" +rs.getString("NAME") +
					"##" + rs.getInt("QUANTITY") + "##" + rs.getDouble("COST");

			//System.out.println(temp_record);
	        result_orders.add(temp_record);
	      	}
	      	return result_orders;
	    } catch (SQLException sqlex) {
	      sqlex.printStackTrace();
	    }
	    return null;

	}

	public int orderProducts(int userID, int productID, int quantity, int orderID) {
			int oID = 0;
			String type = "";
			@SuppressWarnings("deprecation")
			java.sql.Date pick_up = new java.sql.Date(0, 0, 0);
			Calendar date = Calendar.getInstance();
			java.util.Date today = new java.util.Date();

			java.sql.Date date_placed = new java.sql.Date(today.getTime());
			
			String sql_query = "SELECT DISTINCT count(order_id) FROM banjavi.orders";
			//this creates a new oderID each time when inserting one product at a time
			//change to take in a orderID parameter or ??
			if (orderID == -1) {// flag that means we should return a new orderID (new order has started)			
				try {
					ResultSet rs  = statement_.executeQuery(sql_query);
					while(rs.next()) {
						oID = rs.getInt(1) + 1;
					}
				} catch(SQLException sqlex) {
					sqlex.printStackTrace();
				}
			} else {
				oID = orderID;
			}
			sql_query = "SELECT type FROM banjavi.users WHERE user_id= " + userID;
			
		try {
				ResultSet rs  = statement_.executeQuery(sql_query);
				while(rs.next()) {
					type = rs.getString(1);
				}
				} catch(SQLException sqlex) {
				sqlex.printStackTrace();
			}
				if(type.equals("Manager")) {
					pick_up = date_placed;
					UpdateStock(productID, quantity);
				}
				
				sql_query = "insert into banjavi.orders values(0," + oID + ", " + userID + ", "
						+ "TO_DATE('" + date_placed + "', 'yyyy-mm-dd'),TO_DATE('" + pick_up + "', 'yyyy-mm-dd'), " +
						productID + ", " + quantity + ")";
				try {
				statement_.executeQuery(sql_query);
				} catch(SQLException sqlex) {
				sqlex.printStackTrace();
				}
		return oID;	
		}

	public  void UpdateStock(int productID, int qty) {
		 String query = "select stock from products where product_id = "+ productID;
		 try{
		 ResultSet rs  = statement_.executeQuery(query);
		 while(rs.next()){
				qty = rs.getInt(1) + qty;
			}
		 
		   String sql_query = "UPDATE banjavi.products SET stock = " + qty +" WHERE product_id = " + productID;
		   
			rs  = statement_.executeQuery(sql_query);
				 // should only execute if the user could be inserted
		 } catch (SQLException sqlex) {
				sqlex.printStackTrace();
			}
			
		  
		  }


}
