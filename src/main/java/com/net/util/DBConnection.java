package com.net.util;
import java.sql.*;
public class DBConnection {

	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/result_portal";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "Vanshmysql7@";

    public static Connection getConnection() throws SQLException{
    	try {
    		Class.forName(DRIVER);
    	} catch(ClassNotFoundException e) {
    		throw new SQLException("MySQL driver not found!", e);
    	}
    	return DriverManager.getConnection(URL,USERNAME,PASSWORD);
    }
}
