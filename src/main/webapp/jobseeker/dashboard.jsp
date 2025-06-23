<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.jobportal.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"job_seeker".equals(user.getUserType())) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Job Seeker Dashboard</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<header>
    <div class="logo-container">
        <img src="../images/logo.png" alt="JobPortal Logo" class="logo">
        <h1>Welcome, <%= user.getUsername() %></h1>
    </div>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/profile">My Profile</a></li>
            <li><a href="applications.jsp">My Applications</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </nav>
</header>

<main class="dashboard">
    <h2>Recommended Jobs For You</h2>

    <div class="job-listings">

        <!-- Doogle Job -->
        <div class="job-card">
            <div class="company-logo">
                <img src="${pageContext.request.contextPath}/images/doogle.png" alt="Doogle">
            </div>
            <div class="job-details">
                <h3>Senior Web Developer</h3>
                <p class="company">Doogle</p>
                <p class="location"><i class="fas fa-map-marker-alt"></i> New Delhi, India</p>
                <p class="salary"><i class="fas fa-money-bill-wave"></i> Rs-20lpa</p>
                <p class="job-type"><i class="fas fa-briefcase"></i> Full-time</p>
            </div>
            <div class="job-actions">
                <a href="${pageContext.request.contextPath}/view-job?jobId=1" class="btn btn-light">View Details</a>
                <form action="${pageContext.request.contextPath}/apply-job" method="post">
                    <input type="hidden" name="jobId" value="1">
                    <button type="submit" class="btn-apply">
                        <i class="fas fa-paper-plane"></i> Apply Now
                    </button>
                </form>
            </div>
        </div>

        <!-- Microsoft Job -->
        <div class="job-card">
            <div class="company-logo">
                <img src="${pageContext.request.contextPath}/images/microsoft.png" alt="Microsoft">
            </div>
            <div class="job-details">
                <h3>Cloud Architect</h3>
                <p class="company">Microsoft</p>
                <p class="location"><i class="fas fa-map-marker-alt"></i> Kolkata, India</p>
                <p class="salary"><i class="fas fa-money-bill-wave"></i> Rs-40lpa</p>
                <p class="job-type"><i class="fas fa-briefcase"></i> Full-time</p>
            </div>
            <div class="job-actions">
                <a href="${pageContext.request.contextPath}/view-job?jobId=2" class="btn btn-light">View Details</a>
                <form action="${pageContext.request.contextPath}/apply-job" method="post">
                    <input type="hidden" name="jobId" value="2">
                    <button type="submit" class="btn-apply">
                        <i class="fas fa-paper-plane"></i> Apply Now
                    </button>
                </form>
            </div>
        </div>

        <!-- PingPong Job -->
        <div class="job-card">
            <div class="company-logo">
                <img src="${pageContext.request.contextPath}/images/pingpong.png" alt="PingPong">
            </div>
            <div class="job-details">
                <h3>Product Manager</h3>
                <p class="company">PingPong</p>
                <p class="location"><i class="fas fa-map-marker-alt"></i> Mumbai, India</p>
                <p class="salary"><i class="fas fa-money-bill-wave"></i> Rs-7lpa</p>
                <p class="job-type"><i class="fas fa-briefcase"></i> Full-time</p>
            </div>
            <div class="job-actions">
                <a href="${pageContext.request.contextPath}/view-job?jobId=3" class="btn btn-light">View Details</a>
                <form action="${pageContext.request.contextPath}/apply-job" method="post">
                    <input type="hidden" name="jobId" value="3">
                    <button type="submit" class="btn-apply">
                        <i class="fas fa-paper-plane"></i> Apply Now
                    </button>
                </form>
            </div>
        </div>

        <!-- TechNova Job -->
        <div class="job-card">
            <div class="company-logo">
                <img src="${pageContext.request.contextPath}/images/technova.png" alt="TechNova">
            </div>
            <div class="job-details">
                <h3>AI Engineer</h3>
                <p class="company">TechNova</p>
                <p class="location"><i class="fas fa-map-marker-alt"></i> Remote</p>
                <p class="salary"><i class="fas fa-money-bill-wave"></i> Rs-8lpa</p>
                <p class="job-type"><i class="fas fa-briefcase"></i> Full-time</p>
            </div>
            <div class="job-actions">
                <a href="${pageContext.request.contextPath}/view-job?jobId=4" class="btn btn-light">View Details</a>
                <form action="${pageContext.request.contextPath}/apply-job" method="post">
                    <input type="hidden" name="jobId" value="4">
                    <button type="submit" class="btn-apply">
                        <i class="fas fa-paper-plane"></i> Apply Now
                    </button>
                </form>
            </div>
        </div>

        <!-- GreenEarth Job -->
        <div class="job-card">
            <div class="company-logo">
                <img src="${pageContext.request.contextPath}/images/earthgreen.png" alt="GreenEarth">
            </div>
            <div class="job-details">
                <h3>Environmental Scientist</h3>
                <p class="company">GreenEarth</p>
                <p class="location"><i class="fas fa-map-marker-alt"></i> Boston, MA</p>
                <p class="salary"><i class="fas fa-money-bill-wave"></i> $185,000 - $205,000</p>
                <p class="job-type"><i class="fas fa-briefcase"></i> Full-time</p>
            </div>
            <div class="job-actions">
                <a href="${pageContext.request.contextPath}/view-job?jobId=5" class="btn btn-light">View Details</a>
                <form action="${pageContext.request.contextPath}/apply-job" method="post">
                    <input type="hidden" name="jobId" value="5">
                    <button type="submit" class="btn-apply">
                        <i class="fas fa-paper-plane"></i> Apply Now
                    </button>
                </form>
            </div>
        </div>

    </div>
</main>
</body>
</html>
