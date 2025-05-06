<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.jobportal.model.User, com.jobportal.model.Application" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"job_seeker".equals(user.getUserType())) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String message = (String) session.getAttribute("applicationMessage");
    if (message != null) {
        session.removeAttribute("applicationMessage");
    }

    List<Application> applications = (List<Application>) request.getAttribute("applications");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Applications</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .status.applied { color: green; }
        .status.review { color: orange; }
        .status.rejected { color: red; }
    </style>
</head>
<body>
<header>
    <div class="logo-container">
        <img src="../images/logo.png" alt="JobPortal Logo" class="logo">
        <h1>My Job Applications</h1>
    </div>
    <nav>
        <ul>
            <li><a href="dashboard.jsp">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/profile">My Profile</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </nav>
</header>

<main class="dashboard">
    <h2>Your Recent Applications</h2>

    <% if (message != null) { %>
        <p style="color: green;"><%= message %></p>
    <% } %>

    <div class="application-listings">
        <c:choose>
            <c:when test="${not empty applications}">
                <c:forEach var="app" items="${applications}">
                    <div class="application-card">
                        <div class="application-header">
                            <img src="../images/${app.companyName.toLowerCase()}.png" alt="${app.companyName}" class="company-logo">
                            <div class="application-title">
                                <h3>${app.jobTitle}</h3>
                                <p class="company">${app.companyName}</p>
                            </div>
                            <span class="status ${app.status}">${app.status}</span>
                        </div>
                        <div class="application-details">
                            <p><i class="fas fa-calendar-alt"></i> Applied on: ${app.appliedDate}</p>
                            <p><i class="fas fa-map-marker-alt"></i> Location: ${app.location}</p>
                            <p><i class="fas fa-money-bill-wave"></i> Salary: ₹${app.salary}</p>
                        </div>
                        <div class="application-actions">
                            <a href="job-details.jsp?id=${app.jobId}" class="btn-view">View Job</a>
                            <a href="#" class="btn-withdraw">Withdraw</a>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>You haven't applied to any jobs yet.</p>
            </c:otherwise>
        </c:choose>
    </div>
</main>
</body>
</html>
