package com.jobportal.dao;

import com.jobportal.model.User;
import com.jobportal.util.DatabaseUtil;
import java.sql.*;

public class UserDAO {
    // SQL queries
    private static final String INSERT_USER = 
        "INSERT INTO users (username, password, email, user_type) VALUES (?, ?, ?, ?)";
    private static final String GET_USER_BY_USERNAME = 
        "SELECT * FROM users WHERE username = ?";
    private static final String CHECK_USERNAME = 
        "SELECT COUNT(*) FROM users WHERE username = ?";
    private static final String CHECK_EMAIL = 
        "SELECT COUNT(*) FROM users WHERE email = ?";
    
    /**
     * Registers a new user
     */
    public boolean registerUser(User user) throws SQLException {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_USER, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getUserType());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    user.setUserId(generatedKeys.getInt(1));
                }
            }
            
            return true;
        }
    }
    
    /**
     * Gets user by username
     */
    public User getUserByUsername(String username) throws SQLException {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_USER_BY_USERNAME)) {
            
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setUserType(rs.getString("user_type"));
                    return user;
                }
            }
            return null;
        }
    }
    
    /**
     * Checks if username exists
     */
    public boolean usernameExists(String username) throws SQLException {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(CHECK_USERNAME)) {
            
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }
    
    /**
     * Checks if email exists
     */
    public boolean emailExists(String email) throws SQLException {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(CHECK_EMAIL)) {
            
            stmt.setString(1, email.toLowerCase());
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }
}