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
		protected Statement statement2_;
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
		  statement2_.close();
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
			statement2_ = connection_.createStatement();
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

		public Vector<String> FindAllUsers(String filterType) {
			String sql_query="";
			if(filterType.compareTo("All") == 0){
				 sql_query = "SELECT user_id, username,type FROM banjavi.users order by user_id";
			 }
			else{
				 sql_query = "SELECT user_id, username,type FROM banjavi.users WHERE type = '" + filterType +"' order by user_id " ;
			}
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

		public boolean deleteUser (String id) {
			String sql_query1 = 	"delete from banjavi.orders where user_id=" + id;
			String sql_query2 = 	"delete from banjavi.users where user_id=" + id;
			try {
				ResultSet rs1  = statement_.executeQuery(sql_query1);
				ResultSet rs2  = statement_.executeQuery(sql_query2);
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
	  public Vector<Vector<String>> FindAllProducts(String filterCategory) {
			String sql_query="";
			if(filterCategory.compareTo("All") == 0){
				 sql_query = "SELECT * FROM banjavi.products order by category, name";
			 }
			else{
				 sql_query = "SELECT * FROM banjavi.products WHERE category = '" + filterCategory +"' order by category, name";
				 //SELECT * FROM banjavi.products WHERE category = 'Beverages' order by category, name;
			}
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
	public double TotalCost(int orderID){
	String sql_query = "SELECT SUM(price * CAST(quantity AS number(*,2))) AS \"TOTALCOST\" from banjavi.orders, banjavi.products where banjavi.orders.product_id = banjavi.products.product_id and order_id="+ orderID;
	// SELECT SUM(price * CAST(quantity AS number(*,2))) AS "TOTALCOST" from banjavi.orders, banjavi.products where banjavi.orders.product_id = banjavi.products.product_id and order_id=3;
	double total = 0.0;
	try{
		ResultSet rs  = statement_.executeQuery(sql_query);
		while(rs.next()){
			total=rs.getDouble("TOTALCOST");
		}
	}catch(SQLException sqlex) {
		sqlex.printStackTrace();
	}
	return total;
}

// type is either Manager or Customer
	public Vector<String> viewAllOrders(String type) {
		String sql_query = "SELECT order_id, banjavi.orders.user_id, date_placed, pick_up_date, product_id, quantity FROM banjavi.orders, banjavi.users WHERE banjavi.orders.user_id = banjavi.users.user_id AND type = '" + type + "' ORDER BY order_id";
		try {
		ResultSet rs  = statement_.executeQuery(sql_query);
		Vector<String> result_orders = new Vector<String>();
		while (rs.next()) {
			String temp_record = rs.getInt("ORDER_ID") + "##" + rs.getInt("USER_ID") + "##" + rs.getDate("DATE_PLACED") +
				"##" + rs.getDate("PICK_UP_DATE") + "##" + rs.getInt("PRODUCT_ID") +
				"##" + rs.getInt("QUANTITY");

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

	public Vector<String> viewUnprocessedOrders() {
	@SuppressWarnings("deprecation")
	java.sql.Date d = new java.sql.Date(0, 0, 0);
	String sql_query = "SELECT * FROM banjavi.orders WHERE pick_up_date= TO_DATE('" + d + "', 'yyyy-mm-dd') ";
	try{
		ResultSet rs = statement_.executeQuery(sql_query);
		Vector<String> result_orders = new Vector<String>();
		while(rs.next()) {
			String temp_record = rs.getInt("PURCHASE_ID") + "##" + rs.getInt("ORDER_ID") +
					"##" + rs.getInt("USER_ID") + "##" + rs.getDate("DATE_PLACED") + "##" +
					rs.getDate("PICK_UP_DATE") + "##" + rs.getInt("PRODUCT_ID") + "##" +
					rs.getInt("QUANTITY");
			result_orders.add(temp_record);
		}
		return result_orders;
		} catch (SQLException sqlex) {
			sqlex.printStackTrace();
		}
	return null;
	}

	public void checkout(int orderID) {

		String sql_query = "SELECT product_id, quantity FROM banjavi.orders WHERE order_id= " + orderID;
		int pID = 0;
		int qty = 0;
		try {
			ResultSet rs = statement_.executeQuery(sql_query);
			while(rs.next()) {
				pID = rs.getInt(1);
				//System.out.println(pID);
				qty = rs.getInt(2);
				//System.out.println(qty);
				java.util.Date today = new java.util.Date();
				java.sql.Date pick_up = new java.sql.Date(today.getTime());
				sql_query = "UPDATE banjavi.orders SET pick_up_date = TO_DATE('"+ pick_up +"', 'yyyy-mm-dd') where"
						+ " order_id = "+ orderID;

				ResultSet temp = statement2_.executeQuery(sql_query);

				sql_query = "SELECT stock from banjavi.products WHERE product_id= " + pID;

				ResultSet sto = statement2_.executeQuery(sql_query);
				while(sto.next()) {
					qty = sto.getInt(1) - qty;
				}
				String str = "UPDATE banjavi.products SET stock= " + qty + " WHERE product_id= " + pID;
				ResultSet rs2 = statement2_.executeQuery(str);
			}
		} catch (SQLException sqlex) {
			sqlex.printStackTrace();
		}
	}

	 public Vector<Vector<String>> ProductsToOrder(int number){
                //returns the list of all products with stock less than the inputed number
                String sql_query = "SELECT * FROM banjavi.products WHERE stock < " + number;
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

	 public Vector<Integer> OrdersContainingProduct(int productID){
                //returns a list of all orderIds containing the product
                String sql_query = "SELECT order_id FROM banjavi.orders WHERE product_id = " + productID;
                try {
                        ResultSet rs = statement_.executeQuery(sql_query);
                        Vector<Integer> result_orders = new Vector<Integer>();
                        while(rs.next()) {
                                int temp_record = rs.getInt("ORDER_ID");
                                result_orders.add(temp_record);
                        }
                        return result_orders;
                } catch (SQLException sqlex) {
                        sqlex.printStackTrace();
                }
        return null;


        }

}
