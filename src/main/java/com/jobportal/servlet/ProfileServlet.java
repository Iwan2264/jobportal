package com.jobportal.servlet;

import com.jobportal.dao.JobSeekerDAO;
import com.jobportal.model.JobSeeker;
import com.jobportal.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null || !"job_seeker".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        JobSeekerDAO seekerDAO = new JobSeekerDAO();
        JobSeeker seeker = seekerDAO.getJobSeekerByUserId(user.getUserId());

        if (seeker == null) {
            // If no profile exists, redirect to create profile page
            response.sendRedirect(request.getContextPath() + "/jobseeker/create-profile.jsp");
            return;
        }

        request.setAttribute("seeker", seeker);
        request.getRequestDispatcher("/jobseeker/profile.jsp").forward(request, response);
    }
}