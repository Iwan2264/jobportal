package com.jobportal.servlet;

import com.jobportal.dao.JobSeekerDAO;
import com.jobportal.model.JobSeeker;
import com.jobportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/create-profile")
@MultipartConfig
public class CreateProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !"job_seeker".equals(user.getUserType())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        int age = Integer.parseInt(request.getParameter("age"));
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");
        String skills = request.getParameter("skills");
        int experienceYears = Integer.parseInt(request.getParameter("experienceYears"));
        String education = request.getParameter("education");
        String university = request.getParameter("university");
        String bio = request.getParameter("bio");

        // File uploads (resume + profile picture)
        Part resumePart = request.getPart("resume");
        Part profilePicPart = request.getPart("profilePicture");

        String resumePath = saveFile(resumePart, getServletContext().getRealPath("/uploads/resumes"));
        String profilePicturePath = saveFile(profilePicPart, getServletContext().getRealPath("/uploads/profiles"));

        // Create JobSeeker object
        JobSeeker seeker = new JobSeeker();
        seeker.setUserId(user.getUserId()); // use getUserId(), not getId()
        seeker.setFullName(fullName);
        seeker.setEmail(email);
        seeker.setAge(age);
        seeker.setPhone(phone);
        seeker.setLocation(location);
        seeker.setSkills(skills);
        seeker.setExperienceYears(experienceYears);
        seeker.setEducation(education);
        seeker.setUniversity(university);
        seeker.setBio(bio);
        seeker.setResumePath(resumePath);
        seeker.setProfilePicture(profilePicturePath);

        // Save using DAO
        JobSeekerDAO dao = new JobSeekerDAO();
        boolean success = dao.createJobSeeker(seeker);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/job-seeker/profile.jsp");
        } else {
            request.setAttribute("error", "Failed to save profile. Please try again.");
            request.getRequestDispatcher("/complete-profile.jsp").forward(request, response);
        }
    }

    // Save uploaded file and return relative path
    private String saveFile(Part part, String uploadDir) throws IOException {
        if (part == null || part.getSubmittedFileName() == null || part.getSubmittedFileName().isEmpty()) {
            return null;
        }

        String fileName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();
        java.io.File uploads = new java.io.File(uploadDir);
        if (!uploads.exists()) uploads.mkdirs();

        String filePath = uploadDir + java.io.File.separator + fileName;
        part.write(filePath);
        return "uploads/" + (uploadDir.contains("resumes") ? "resumes/" : "profiles/") + fileName;
    }
}
