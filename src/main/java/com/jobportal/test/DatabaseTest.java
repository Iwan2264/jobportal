package com.jobportal.test;

import com.jobportal.util.DatabaseUtil;
import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseTest {
    public static void main(String[] args) {
        System.out.println("🚀 Starting database connection test...");
        
        Connection conn = null;
        try {
            // Test getting a connection
            System.out.println("1. Attempting to get database connection...");
            conn = DatabaseUtil.getConnection();
            System.out.println("✅ Successfully connected to database!");
            
            // Test basic database operations
            System.out.println("\n2. Testing database metadata...");
            System.out.println("   Database: " + conn.getMetaData().getDatabaseProductName());
            System.out.println("   Version: " + conn.getMetaData().getDatabaseProductVersion());
            
        } catch (SQLException e) {
            System.err.println("❌ Connection failed!");
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Message: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Close connection
            if (conn != null) {
                try {
                    System.out.println("\n3. Closing connection...");
                    conn.close();
                    System.out.println("✅ Connection closed properly");
                } catch (SQLException e) {
                    System.err.println("❌ Error closing connection: " + e.getMessage());
                }
            }
            System.out.println("\n🏁 Test completed");
        }
    }
}