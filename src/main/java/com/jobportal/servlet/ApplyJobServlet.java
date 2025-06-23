package com.jobportal.servlet;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.dao.JobSeekerDAO;
import com.jobportal.model.Application;
import com.jobportal.model.JobSeeker;
import com.jobportal.model.User;
import com.jobportal.util.DatabaseUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/apply-job")
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"job_seeker".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int jobId;
        try {
            jobId = Integer.parseInt(request.getParameter("jobId"));
            System.out.println("Job ID received: " + jobId);
        } catch (NumberFormatException e) {
            System.out.println("Invalid Job ID format");
            response.sendRedirect(request.getContextPath() + "/jobseeker/dashboard.jsp?error=Invalid+Job+ID");
            return;
        }

        JobSeekerDAO seekerDAO = new JobSeekerDAO();
        JobSeeker seeker = seekerDAO.getJobSeekerByUserId(user.getUserId());

        if (seeker == null) {
            System.out.println("Seeker not found for userId: " + user.getUserId());
            response.sendRedirect(request.getContextPath() + "/jobseeker/profile.jsp?error=Complete+your+profile+first");
            return;
        }

        Application application = new Application();
        application.setJobId(jobId);
        application.setSeekerId(seeker.getSeekerId());
        application.setStatus("applied");

        try (Connection conn = DatabaseUtil.getConnection()) {
            ApplicationDAO appDAO = new ApplicationDAO(conn);
            boolean isSaved = appDAO.createApplication(application);

            if (isSaved) {
                System.out.println("Application saved successfully");
                session.setAttribute("applicationMessage", "Application submitted successfully!");
                response.sendRedirect(request.getContextPath() + "/jobseeker/applications.jsp");
            } else {
                System.out.println("Failed to save application");
                response.sendRedirect(request.getContextPath() + "/job-details.jsp?id=" + jobId + "&error=Failed+to+submit+application");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Important: See the error in console
            response.sendRedirect(request.getContextPath() + "/job-details.jsp?id=" + jobId + "&error=Internal+Server+Error");
        }
    }
}
