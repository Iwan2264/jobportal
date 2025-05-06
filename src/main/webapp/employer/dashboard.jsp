<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.jobportal.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"employer".equals(user.getUserType())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Employer Dashboard - DodoJobs</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <header>
        <div class="logo-container">
            <img src="../images/logo.png" alt="DodoJobs Logo" class="logo">
            <h1>Employer Dashboard</h1>
        </div>
        <nav>
            <ul>
                <li><a href="post-job.jsp">Post New Job</a></li>
                <li><a href="view-applications.jsp">View Applications</a></li>
                <li><a href="../logout">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main class="dashboard">
        <h2>Your Posted Jobs</h2>
        <!-- Employer content will go here -->
    </main>
</body>
</html>