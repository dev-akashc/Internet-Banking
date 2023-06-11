package p;

import java.io.Serializable;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class PDAOU implements Serializable {

	private Connection con;

	public PDAOU() {
		estabcon();
	}

	private void estabcon() {
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			con = DriverManager.getConnection("jdbc:odbc:abc", "root", "root");
		} catch (Exception e) {
			System.out.println("Connection error: " + e);
		}
	}

	/*
	 * mysql> create table accd(cac integer(14),bal float(10,2),bcode integer(5));
	 * create table widep(cac integer(14),ddate date,dtime time,type varchar(1),
	 * amount float(10,2)
	 */

	public ArrayList transfer(Integer nname, Float name, ArrayList a, Integer rec) throws SQLException {
		try {
			// Withdraw from sender
			String sql = "update accd set bal=bal-" + name + " where cac=" + nname;
			try (Statement stmt = con.createStatement()) {
				stmt.executeUpdate(sql);
			}

			// Insert withdraw record
			String dat = getCurrentDate();
			String tim = getCurrentTime();
			sql = "insert into widep values(" + nname + ",'" + dat + "','" + tim + "','W'," + name + ")";
			try (Statement stmt = con.createStatement()) {
				stmt.executeUpdate(sql);
			}

			// Deposit to receiver
			sql = "update accd set bal=bal+" + name + " where cac=" + rec;
			try (Statement stmt = con.createStatement()) {
				stmt.executeUpdate(sql);
			}

			// Insert deposit record
			dat = getCurrentDate();
			tim = getCurrentTime();
			sql = "insert into widep values(" + rec + ",'" + dat + "','" + tim + "','D'," + name + ")";
			try (Statement stmt = con.createStatement()) {
				stmt.executeUpdate(sql);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			closeConnection();
		}
		return a;
	}

	public ArrayList uppay(Integer nname, Float name, ArrayList a) throws SQLException {
		try {
			// Withdraw amount
			String sql = "update accd set bal=bal-" + name + " where cac=" + nname;
			try (Statement stmt = con.createStatement()) {
				stmt.executeUpdate(sql);
			}

			// Insert withdraw record
			String dat = getCurrentDate();
			String tim = getCurrentTime();
			sql = "insert into widep values(" + nname + ",'" + dat + "','" + tim + "','W'," + name + ")";
			try (Statement stmt = con.createStatement()) {
				stmt.executeUpdate(sql);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			closeConnection();
		}
		return a;
	}

	public void emailupd(String nname, String name) throws SQLException {
		try {
			String sql = "update custp set pass='" + name + "' where cid=" + nname;
			try (Statement stmt = con.createStatement()) {
				stmt.executeUpdate(sql);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			closeConnection();
		}
	}

	public void nameupd(String nname, String name) throws SQLException {
		try {
			String sql = "update custd set cname='" + name + "' where cid=" + nname;
			try (Statement stmt = con.createStatement()) {
				stmt.executeUpdate(sql);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			closeConnection();
		}
	}

	public void mobileupd(String nname, Long name) throws SQLException {
		try {
			String sql = "update custd set cmobile=" + name + " where cid=" + nname;
			try (Statement stmt = con.createStatement()) {
				stmt.executeUpdate(sql);
			}
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			closeConnection();
		}
	}

	private String getCurrentDate() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		return dateFormat.format(new Date());
	}

	private String getCurrentTime() {
		DateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
		return timeFormat.format(new Date());
	}

	private void closeConnection() {
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				System.out.println("Error closing connection: " + e);
			}
		}
	}
}
