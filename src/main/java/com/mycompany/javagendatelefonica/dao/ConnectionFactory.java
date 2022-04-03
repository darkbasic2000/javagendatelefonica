package com.mycompany.javagendatelefonica.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectionFactory {
 
    public static Connection getConnection() {
        try {
            return DriverManager.getConnection("jdbc:mysql://localhost/javagendatelefonica", "java", "java");
        }
        catch(SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static void closeConnection(Connection conn, Statement stmt, ResultSet rs) {
        close(conn, stmt, rs);
    }
    
    public static void closeConnection(Connection conn, Statement stmt) {
        close(conn, stmt, null);
    }
    
    public static void closeConnection(Connection conn) {
        close(conn, null, null);
    }
    
    private static void close(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if(rs!= null) {
                rs.close();
            }
            if(stmt != null) {
                stmt.close();
            }
            if(rs != null) {
                rs.close();
            }
        }
        catch(SQLException e) {
            e.printStackTrace();
        }
    }
    
}