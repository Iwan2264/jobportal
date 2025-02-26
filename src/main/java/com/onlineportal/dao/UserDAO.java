package com.onlineportal.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.onlineportal.model.User;

public class UserDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/onlineportal";
    private String jdbcUsername = "root";
    private String jdbcPassword = "qwerty123";

    private static final String INSERT_USER_SQL = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?);";
    private static final String SELECT_USER_BY_EMAIL = "SELECT * FROM users WHERE email = ?;";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void insertUser(User user) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getRole());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public User selectUserByEmail(String email) {
        User user = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_EMAIL)) {
            preparedStatement.setString(1, email);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String role = rs.getString("role");
                user = new User();
                user.setId(id);
                user.setName(name);
                user.setEmail(email);
                user.setPassword(password);
                user.setRole(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}