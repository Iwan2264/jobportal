package com.jobportal.servlet;

import com.jobportal.dao.JobDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/job-details")
public class JobDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int jobId = Integer.parseInt(request.getParameter("id"));
            JobDAO jobDao = new JobDAO();
            request.setAttribute("job", jobDao.getJobById(jobId));
            request.getRequestDispatcher("/job-details.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/jobseeker/dashboard.jsp?error=Invalid+Job+ID");
        }
    }
}