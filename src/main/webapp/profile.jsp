<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.jobportal.model.User, com.jobportal.dao.JobSeekerDAO, com.jobportal.model.JobSeeker" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"job_seeker".equals(user.getUserType())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    JobSeekerDAO seekerDao = new JobSeekerDAO();
    JobSeeker seeker = seekerDao.getJobSeekerByUserId(user.getUserId());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile - DodoJobs</title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        header {
            background: linear-gradient(135deg, #6e48aa 0%, #9d50bb 100%);
            color: white;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .logo-container {
            display: flex;
            align-items: center;
        }
        .logo {
            height: 50px;
            margin-right: 15px;
        }
        nav ul {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
        }
        nav ul li a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        nav ul li a:hover {
            background-color: rgba(255,255,255,0.2);
            border-radius: 4px;
        }
        .profile-container {
            max-width: 1000px;
            margin: 2rem auto;
            padding: 2rem;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #6e48aa;
            margin-bottom: 2rem;
        }
        .profile-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }
        .profile-info, .profile-skills {
            background: #fafafa;
            padding: 1.5rem;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }
        .profile-info h2, .profile-skills h2 {
            color: #6e48aa;
            margin-bottom: 1rem;
        }
        .profile-info p, .profile-skills p {
            margin: 0.5rem 0;
        }
        .btn {
            display: inline-block;
            margin-top: 1rem;
            background: linear-gradient(135deg, #6e48aa 0%, #9d50bb 100%);
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(110, 72, 170, 0.3);
        }
        .logout-options {
            margin-top: 2rem;
            text-align: center;
        }
        .btn-logout {
            margin: 0.5rem;
            padding: 10px 20px;
            font-size: 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-logout.temporary {
            background: #ddd;
            color: #333;
        }
        .btn-logout.permanent {
            background: #e74c3c;
            color: white;
        }
    </style>
</head>
<body>
    <header>
        <div class="logo-container">
            <img src="../images/logo.png" alt="DodoJobs Logo" class="logo">
            <div>
                <h1>DodoJobs</h1>
                <p class="tagline" style="display: none;">Simple. Swift. Dodo.</p>
            </div>
        </div>
        <nav>
            <ul>
                <li><a href="../index.jsp">Home</a></li>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="../logout">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main class="profile-container">
        <h1>My Profile</h1>

        <div class="profile-section">
            <div class="profile-info">
                <h2>Personal Information</h2>
                <p><strong>Name:</strong> <%= seeker.getFullName() %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
                <p><strong>Age:</strong> <%= seeker.getAge() %></p>
                <p><strong>Experience:</strong> <%= seeker.getExperienceYears() %> years</p>
                <p><strong>Education:</strong> <%= seeker.getEducation() != null ? seeker.getEducation() : "N/A" %></p>
                <% if (seeker.getResumePath() != null) { %>
                    <p><strong>Resume:</strong> 
                        <a href="../download?file=<%= seeker.getResumePath() %>" target="_blank">Download Resume</a>
                    </p>
                <% } %>
            </div>

            <div class="profile-skills">
                <h2>Skills</h2>
                <p><%= seeker.getSkills() != null ? seeker.getSkills() : "No skills mentioned." %></p>

                <h2>Applied Jobs</h2>
                <a href="dashboard.jsp" class="btn">View My Applications</a>
            </div>
        </div>

        <div class="logout-options">
            <h2>Logout Options</h2>
            <button onclick="confirmLogout(false)" class="btn-logout temporary">Temporary Logout</button>
            <button onclick="confirmLogout(true)" class="btn-logout permanent">Permanent Logout</button>
        </div>
    </main>

    <script>
        function confirmLogout(isPermanent) {
            if (isPermanent) {
                if (confirm("Are you sure you want to permanently logout?")) {
                    window.location.href = "../logout?type=permanent";
                }
            } else {
                window.location.href = "../logout";
            }
        }
    </script>
</body>
</html>
