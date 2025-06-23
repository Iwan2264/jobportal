package com.jobportal.servlet;

import com.jobportal.dao.JobSeekerDAO;
import com.jobportal.model.JobSeeker;
import com.jobportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/saveProfile")
public class SaveProfileServlet extends HttpServlet {
    private JobSeekerDAO jobSeekerDAO;

    @Override
    public void init() throws ServletException {
        jobSeekerDAO = new JobSeekerDAO(); // You must have this DAO created
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        if (user == null || !"job_seeker".equals(user.getUserType())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");

        JobSeeker seeker = new JobSeeker();
        seeker.setUserId(user.getId());
        seeker.setFullName(fullName);

        boolean success = jobSeekerDAO.createJobSeeker(seeker);

        if (success) {
            response.sendRedirect("profile.jsp");
        } else {
            response.sendRedirect("complete-profile.jsp?error=1");
        }
    }
}
