package com.jobportal.util;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

public class DatabaseUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/jobportal";
    private static final String USER = "root";       // your MySQL username
    private static final String PASSWORD = "shonu";  // your MySQL password

    // Load JDBC driver once
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver Registered!");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("MySQL JDBC Driver not found");
        }
    }

    // Get DB connection
    public static Connection getConnection() throws SQLException {
        System.out.println("Connecting to DB: " + URL);
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Close DB connection
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Connection closed successfully");
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }

    // Shutdown hook to clean up drivers and threads
    public static void shutdown() {
        System.out.println("Shutting down database resources...");

        // Deregister JDBC drivers
        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
                System.out.println("Deregistered JDBC driver: " + driver);
            } catch (SQLException e) {
                System.err.println("Error deregistering driver: " + e.getMessage());
            }
        }

        // Clean up MySQL abandoned connection thread
        try {
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("MySQL cleanup thread stopped");
        } catch (Exception e) {
            System.err.println("Error stopping MySQL cleanup thread");
            e.printStackTrace();
        }
    }
}
