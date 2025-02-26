package com.onlineportal.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.onlineportal.dao.UserDAO;
import com.onlineportal.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.selectUserByEmail(email);

        if (user != null && user.getPassword().equals(password)) {
            // Redirect based on role
            if (user.getRole().equals("Job Seeker")) {
                response.sendRedirect("user/dashboard.jsp");
            } else if (user.getRole().equals("Employer")) {
                response.sendRedirect("employer/dashboard.jsp");
            } else if (user.getRole().equals("Admin")) {
                response.sendRedirect("admin/dashboard.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}