<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/theme.css">
</head>
<body>
    <header>
        <div class="logo-container">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="DodoJobs Logo">
            <div>
                <h1>DodoJobs</h1>
                <p class="tagline">Simple. Swift. Dodo.</p>
            </div>
        </div>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/jobs.jsp">Browse Jobs</a></li>
                <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
            </ul>
        </nav>
    </header>
    <%@ include file="theme-toggle.jsp" %>