package com.jobportal.servlet;

import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/view-job")
public class ViewJobServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String jobIdParam = request.getParameter("jobId");

        try {
            int jobId = Integer.parseInt(jobIdParam);
            JobDAO dao = new JobDAO();
            Job job = dao.getJobById(jobId);

            if (job != null) {
                request.setAttribute("job", job);
                request.getRequestDispatcher("/jobseeker/job-details.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Job not found.");
                request.getRequestDispatcher("/jobseeker/dashboard.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("jobseeker/dashboard.jsp");
        }
    }
}
