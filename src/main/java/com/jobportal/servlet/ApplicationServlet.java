package com.jobportal.servlet;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.dao.JobSeekerDAO;
import com.jobportal.model.Application;
import com.jobportal.model.JobSeeker;
import com.jobportal.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/apply")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1MB
    maxFileSize = 1024 * 1024 * 5,      // 5MB
    maxRequestSize = 1024 * 1024 * 10   // 10MB
)
public class ApplicationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "resumes";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"job_seeker".equals(user.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int jobId = Integer.parseInt(request.getParameter("jobId"));
            Part filePart = request.getPart("resume");

            if (filePart == null || filePart.getSize() == 0) {
                throw new ServletException("Resume file is required");
            }

            JobSeekerDAO seekerDao = new JobSeekerDAO();
            JobSeeker seeker = seekerDao.getJobSeekerByUserId(user.getUserId());

            if (seeker == null) {
                seeker = createNewJobSeeker(request, user);
                String resumePath = saveResumeFile(filePart, request.getServletContext().getRealPath(""));
                seeker.setResumePath(resumePath);
                boolean created = seekerDao.createJobSeeker(seeker); // ✅ FIXED LINE
                if (!created) {
                    throw new ServletException("Failed to create job seeker profile.");
                }
                seeker = seekerDao.getJobSeekerByUserId(user.getUserId()); // fetch after creation
            }

            Application application = new Application();
            application.setJobId(jobId);
            application.setSeekerId(seeker.getSeekerId());
            application.setApplicationDate(LocalDateTime.now());
            application.setStatus("Submitted");

            ApplicationDAO appDao = new ApplicationDAO();
            boolean success = appDao.createApplication(application);

            if (success) {
                session.setAttribute("successMessage", "Application submitted successfully!");
                response.sendRedirect("jobseeker/applications.jsp");
            } else {
                throw new ServletException("Failed to submit application");
            }

        } catch (Exception e) {
            request.setAttribute("error", "Application Error: " + e.getMessage());
            request.getRequestDispatcher("job-details.jsp?id=" + request.getParameter("jobId"))
                    .forward(request, response);
        }
    }

    private JobSeeker createNewJobSeeker(HttpServletRequest request, User user) {
        JobSeeker seeker = new JobSeeker();
        seeker.setUserId(user.getUserId());
        seeker.setFullName(request.getParameter("fullName"));
        seeker.setEmail(request.getParameter("email"));

        try {
            seeker.setAge(Integer.parseInt(request.getParameter("age")));
            seeker.setExperienceYears(Integer.parseInt(request.getParameter("experience")));
        } catch (NumberFormatException e) {
            seeker.setAge(0);
            seeker.setExperienceYears(0);
        }

        seeker.setPhone(request.getParameter("phone"));
        seeker.setLocation(request.getParameter("location"));
        seeker.setSkills(request.getParameter("skills"));
        seeker.setEducation(request.getParameter("education"));
        seeker.setUniversity(request.getParameter("university"));
        seeker.setBio(request.getParameter("bio"));
        seeker.setProfilePicture(null); // Set later if needed

        return seeker;
    }

    private String saveResumeFile(Part filePart, String appPath) throws IOException {
        Path uploadPath = Paths.get(appPath, UPLOAD_DIR);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String fileName = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")) +
                "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        Path filePath = uploadPath.resolve(fileName);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
        }

        return UPLOAD_DIR + "/" + fileName;
    }
}
