package com.jobportal.servlet;

import com.jobportal.dao.UserDAO;
import com.jobportal.model.User;
import com.jobportal.util.PasswordHasher;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Null-safe trim
        username = (username != null) ? username.trim() : "";
        password = (password != null) ? password : "";

        // Input validation
        if (username.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            // Fetch user by username
            User user = userDao.getUserByUsername(username);

            // Verify password using hashed storage
            if (user != null && PasswordHasher.verifyPassword(password, user.getPassword())) {

                // End old session and start a clean one
                HttpSession oldSession = request.getSession(false);
                if (oldSession != null) oldSession.invalidate();

                HttpSession newSession = request.getSession(true);
                newSession.setAttribute("user", user);
                newSession.setMaxInactiveInterval(30 * 60); // 30 mins

                // Absolute redirect path based on user type
                String redirectPath = request.getContextPath() +
                        ( "job_seeker".equals(user.getUserType()) ? "/jobseeker/dashboard.jsp" :
                          "employer".equals(user.getUserType())   ? "/employer/dashboard.jsp" :
                          "admin".equals(user.getUserType())      ? "/admin/dashboard.jsp" :
                                                                  "/index.jsp" );

                System.out.println("User type: " + user.getUserType());
                System.out.println("Redirecting to: " + redirectPath);
                response.sendRedirect(redirectPath);

            } else {
                request.setAttribute("error", "Invalid username or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "A database error occurred.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
