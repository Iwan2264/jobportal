<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Job Seeker Dashboard</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <header>
        <div class="logo-container">
            <img src="../images/logo.png" alt="DodoJobs Logo" class="logo">
            <div>
                <h1>DodoJobs</h1>
                <p class="tagline">Welcome to your dashboard</p>
            </div>
        </div>
        <nav>
            <ul>
                <li><a href="../index.jsp">Home</a></li>
                <li><a href="../logout">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <div class="dashboard-container">
            <h2>Welcome, ${user.username}!</h2>
            
            <div class="dashboard-section">
                <h3>Your Profile</h3>
                <p>Email: ${user.email}</p>
                <a href="profile.jsp" class="btn">Edit Profile</a>
            </div>
            
            <div class="dashboard-section">
                <h3>Recent Applications</h3>
                <!-- Applications list will go here -->
                <p>You haven't applied to any jobs yet.</p>
                <a href="../jobs.jsp" class="btn">Browse Jobs</a>
            </div>
        </div>
    </main>
</body>
</html>