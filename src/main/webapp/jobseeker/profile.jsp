<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jobportal.dao.JobSeekerDAO, com.jobportal.model.JobSeeker, com.jobportal.model.User" %>
<%
    // You do NOT need to declare `HttpSession session` because it's implicit in JSP
    User user = (User) session.getAttribute("user");

    if (user == null || !"job_seeker".equals(user.getUserType())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    JobSeekerDAO jobSeekerDAO = new JobSeekerDAO();
    JobSeeker jobSeeker = jobSeekerDAO.getJobSeekerByUserId(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Job Seeker Profile</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .profile-box {
            max-width: 600px;
            margin: auto;
            padding: 30px;
            border-radius: 10px;
            background-color: #f8f8f8;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .profile-box h2 { text-align: center; }
        .profile-info { margin-top: 20px; }
        .profile-info p { margin: 10px 0; }
    </style>
</head>
<body>
    <div class="profile-box">
        <h2>My Profile</h2>
        <div class="profile-info">
            <p><strong>Full Name:</strong> <%= jobSeeker.getFullName() %></p>
            <p><strong>Email:</strong> <%= user.getEmail() %></p>
            <p><strong>Phone:</strong> <%= jobSeeker.getPhone() %></p>
            <p><strong>Education:</strong> <%= jobSeeker.getEducation() %></p>
            <%-- <p><strong>Experience:</strong> <%= jobSeeker.getExperience() %></p>--%>
            <p><strong>Skills:</strong> <%= jobSeeker.getSkills() %></p>
        </div>
    </div>
</body>
</html>
