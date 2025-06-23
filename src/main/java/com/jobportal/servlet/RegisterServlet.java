package com.jobportal.servlet;

import com.jobportal.dao.UserDAO;
import com.jobportal.model.User;
import com.jobportal.util.PasswordHasher;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Logger for debugging (optional but recommended)
        Logger logger = Logger.getLogger(RegisterServlet.class.getName());

        // Get form data safely (null-safe trimming)
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String userType = request.getParameter("userType");

        username = (username != null) ? username.trim() : "";
        password = (password != null) ? password.trim() : "";
        email = (email != null) ? email.trim().toLowerCase() : "";

        List<String> errors = new ArrayList<>();

        // Input validation
        if (username.isEmpty()) errors.add("Username is required");
        if (password.isEmpty()) errors.add("Password is required");
        if (email.isEmpty()) errors.add("Email is required");

        // Regex validations
        if (!email.matches("^[\\w-.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            errors.add("Invalid email format");
        }

        if (!password.matches("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$")) {
            errors.add("Password must be at least 8 characters with uppercase, lowercase, and number");
        }

        // If errors, send back to form
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            // Check for duplicate username or email
            if (userDao.usernameExists(username)) {
                errors.add("Username already exists");
            }

            if (userDao.emailExists(email)) {
                errors.add("Email already registered");
            }

            if (!errors.isEmpty()) {
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Hash the password
            String hashedPassword = PasswordHasher.hashPassword(password);

            // Create new user object
            User newUser = new User(username, hashedPassword, email, userType);

            // Save to DB
            boolean registered = userDao.registerUser(newUser);

            if (registered) {
                // Redirect to login with success message
                response.sendRedirect("login.jsp?registration=success");
            } else {
                // Internal error
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error during registration", e);
            request.setAttribute("error", "An error occurred while accessing the database.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
